create table public.user_profiles (
    id uuid not null,
    username text null,
    avatar_url text null,
    mobile_number text null,
    first_name text null,
    last_name text null,
    birth_date text null,
    gender_id uuid null,
    updated_at timestamp with time zone null default (now() at time zone 'utc'::text),
    constraint profiles_pkey primary key (id),
    constraint profiles_username_key unique (username),
    constraint user_profiles_gender_id_fkey foreign key (gender_id) references ref_generic_list_sub (id),
    constraint user_profiles_id_fkey foreign key (id) references auth.users (id) on delete cascade,
    constraint username_length check ((char_length(username) >= 3))
  ) tablespace pg_default;


alter table user_profiles
  enable row level security;

create policy "Public user_profiles are viewable by everyone." on user_profiles
  for select using (true);

create policy "Users can insert their own profile." on user_profiles
  for insert with check (auth.uid() = id);

create policy "Users can update own profile." on user_profiles
  for update using (auth.uid() = id);


 -- drop function handle_new_user
 -- drop trigger on_auth_user_created
create or replace function public.handle_new_user()
  returns trigger as $$
DECLARE
  full_name_parts text[];
  first_name text;
  last_name text;
begin
    -- Split full_name into first_name and last_name
    full_name_parts := string_to_array(new.raw_user_meta_data->>'full_name', ' ');
    first_name := COALESCE(full_name_parts[1], 'First_name');
    last_name := COALESCE(full_name_parts[2], 'Last_name');
  insert into public.user_profiles (id, first_name, last_name, avatar_url, username)
  values (
    new.id, 
    first_name,
    last_name,
    COALESCE(new.raw_user_meta_data->>'avatar_url', ''),
    COALESCE(new.raw_user_meta_data->>'email', 'username@default.com')
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

/*
If it's not null, we use the values from raw_user_meta_data using the COALESCE function to handle null values and set default values if necessary.
*/