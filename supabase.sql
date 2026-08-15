-- KARANLIK DERGİ / SUPABASE KURULUMU

create table if not exists public.posts (
  id uuid primary key default gen_random_uuid(),

  title text not null,

  slug text unique not null,

  excerpt text default '',

  category text default 'random',

  tags text[] default '{}',

  cover_url text default '',

  content text not null,

  read_time integer default 5,

  published boolean default false,

  published_at timestamptz,

  created_at timestamptz default now()
);


-- GÜVENLİK

alter table public.posts enable row level security;


-- HERKES YAYINLANAN YAZILARI OKUYABİLSİN

drop policy if exists
"Herkes yayınlanan yazıları okuyabilir"
on public.posts;

create policy
"Herkes yayınlanan yazıları okuyabilir"

on public.posts

for select

using (
  published = true
);


-- GİRİŞ YAPAN ADMİN YAZI EKLEYEBİLSİN

drop policy if exists
"Giriş yapan admin yazı ekleyebilir"
on public.posts;

create policy
"Giriş yapan admin yazı ekleyebilir"

on public.posts

for insert

to authenticated

with check (true);


-- GİRİŞ YAPAN ADMİN YAZI DÜZENLEYEBİLSİN

drop policy if exists
"Giriş yapan admin yazı düzenleyebilir"
on public.posts;

create policy
"Giriş yapan admin yazı düzenleyebilir"

on public.posts

for update

to authenticated

using (true)

with check (true);


-- GİRİŞ YAPAN ADMİN YAZI SİLEBİLSİN

drop policy if exists
"Giriş yapan admin yazı silebilir"
on public.posts;

create policy
"Giriş yapan admin yazı silebilir"

on public.posts

for delete

to authenticated

using (true);
