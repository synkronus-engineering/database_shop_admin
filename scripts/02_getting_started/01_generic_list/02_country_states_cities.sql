-- Coutries
create table
  public.ref_countries (
    id bigint generated by default as identity,
    nombre character varying(300) null,
    area_code character varying(300) null,
    codigo character varying(300) null,
    constraint countries_pkey primary key (id)
  ) tablespace pg_default;


alter table ref_countries enable row level security;
create policy "Everyone can select from ref_countries. " on ref_countries for
    select using (true);


-- Colombian States
create table
  public.ref_colombian_states (
    id bigint generated by default as identity,
    nombre text null,
    codigo integer null,
    constraint colombian_states_pkey primary key (id)
  ) tablespace pg_default;

alter table colombian_states enable row level security;
create policy "Everyone can select from colombian_states. " on colombian_states for
    select using (true);


-- Colombian Cities
	create table
  public.ref_colombian_cities (
    id bigint generated by default as identity,
    departamento_id bigint not null,
    codigo integer null,
    nombre text null,
    constraint colombian_cities_pkey primary key (id),
    constraint ref_colombian_cities_departamento_id_fkey foreign key (departamento_id) references ref_colombian_states (id)
  ) tablespace pg_default;


alter table ref_colombian_cities enable row level security;
create policy "Everyone can select from ref_colombian_cities. " on ref_colombian_cities for
    select using (true);