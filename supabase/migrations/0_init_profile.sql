-- Enable required extensions
-- Drop and recreate to ensure it's in the public schema
drop extension if exists "uuid-ossp" cascade;
create extension "uuid-ossp" with schema public;

-- User Profile table (extends Supabase auth.users)
create table public.profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  name text,
  subscription_plan text check (subscription_plan in ('free', 'premium')) default 'free',
  tasks_limit integer default 100,
  stripe_customer_id text,
  created_at timestamp with time zone default timezone('utc'::text, now()),
  updated_at timestamp with time zone default timezone('utc'::text, now())
);
