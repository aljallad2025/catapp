-- ========================================
-- The Cat House Oman - مخطط قاعدة البيانات
-- نفّذ هذا الملف كاملاً في Supabase SQL Editor
-- ========================================

-- جدول الملفات الشخصية (يُربط تلقائياً بجدول auth.users)
create table if not exists public.profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text,
  phone text,
  avatar_url text,
  created_at timestamp with time zone default now()
);

alter table public.profiles enable row level security;

create policy "المستخدم يقدر يشوف ملفه الشخصي"
  on public.profiles for select
  using (auth.uid() = id);

create policy "المستخدم يقدر يعدل ملفه الشخصي"
  on public.profiles for update
  using (auth.uid() = id);

-- دالة تريغر تنشئ صف profile تلقائياً عند إنشاء حساب جديد
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, full_name, phone)
  values (
    new.id,
    new.raw_user_meta_data->>'full_name',
    new.raw_user_meta_data->>'phone'
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ========================================
-- جدول العناصر (يخدم كل الأقسام السبعة عبر عمود section)
-- ========================================
create table if not exists public.items (
  id uuid default gen_random_uuid() primary key,
  section text not null check (section in
    ('sale','mating','adoption','food','accessories','hotel','vet')),
  title text not null,
  subtitle text,
  price numeric(10,2) default 0,
  currency text default 'ر.ع',
  image_url text,
  rating numeric(2,1) default 0,
  reviews_count int default 0,
  breed text,
  age text,
  gender text,
  description text,
  seller_id uuid references auth.users,
  seller_name text,
  seller_phone text,
  is_active boolean default true,
  created_at timestamp with time zone default now()
);

alter table public.items enable row level security;

create policy "الجميع يقدر يشوف العناصر النشطة"
  on public.items for select
  using (is_active = true);

create policy "المستخدم المسجل يقدر يضيف عنصر"
  on public.items for insert
  with check (auth.uid() = seller_id);

create policy "البائع يقدر يعدل عناصره فقط"
  on public.items for update
  using (auth.uid() = seller_id);

create index if not exists items_section_idx on public.items(section);

-- ========================================
-- جدول الحجوزات/الطلبات
-- ========================================
create table if not exists public.bookings (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  item_id uuid references public.items not null,
  booking_date date,
  quantity int default 1,
  total_price numeric(10,2) not null,
  status text default 'pending' check (status in
    ('pending','confirmed','completed','cancelled')),
  payment_method text,
  order_number text unique,
  created_at timestamp with time zone default now()
);

alter table public.bookings enable row level security;

create policy "المستخدم يشوف حجوزاته فقط"
  on public.bookings for select
  using (auth.uid() = user_id);

create policy "المستخدم يقدر يضيف حجز"
  on public.bookings for insert
  with check (auth.uid() = user_id);

-- ========================================
-- جدول المفضلة
-- ========================================
create table if not exists public.favorites (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references auth.users not null,
  item_id uuid references public.items not null,
  created_at timestamp with time zone default now(),
  unique(user_id, item_id)
);

alter table public.favorites enable row level security;

create policy "المستخدم يدير مفضلته فقط"
  on public.favorites for all
  using (auth.uid() = user_id);

-- ========================================
-- تخزين الصور (Storage bucket)
-- شغّل هذا الجزء من واجهة Supabase Storage وليس SQL Editor:
-- 1) أنشئ bucket باسم "items-images" واجعله Public
-- 2) أنشئ bucket باسم "avatars" واجعله Public
-- ========================================
