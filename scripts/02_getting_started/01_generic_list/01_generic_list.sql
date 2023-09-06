create table
  public.ref_generic_list_cat (
    id uuid not null default uuid_generate_v4 (),
    code text null,
    name text null,
    description text null,
    order_list smallint null,
    constraint generic_list_cat_pkey primary key (id)
  ) tablespace pg_default;

  create table
  public.ref_generic_list_sub (
    id uuid not null default uuid_generate_v4 (),
    generic_list_cat_id uuid null,
    code text null,
    name text null,
    order_list smallint null,
    meta text null,
    constraint generic_list_sub_pkey primary key (id),
    constraint ref_generic_list_sub_generic_list_cat_id_fkey foreign key (generic_list_cat_id) references ref_generic_list_cat (id)
  ) tablespace pg_default;