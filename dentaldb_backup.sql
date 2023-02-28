--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: clinic; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA clinic;


ALTER SCHEMA clinic OWNER TO admin;

--
-- Name: dentalschema; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA dentalschema;


ALTER SCHEMA dentalschema OWNER TO admin;

--
-- Name: s1; Type: SCHEMA; Schema: -; Owner: admin
--

CREATE SCHEMA s1;


ALTER SCHEMA s1 OWNER TO admin;

--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: day; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.day AS ENUM (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);


ALTER TYPE public.day OWNER TO admin;

--
-- Name: fullname; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.fullname AS (
	firstname character varying(50),
	middlename character varying(50),
	lastname character varying(50)
);


ALTER TYPE public.fullname OWNER TO admin;

--
-- Name: gender; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.gender AS ENUM (
    'Male',
    'Female',
    'Transgender'
);


ALTER TYPE public.gender OWNER TO admin;

--
-- Name: name; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.name AS (
	firstname text,
	middlename text,
	lastname text
);


ALTER TYPE public.name OWNER TO admin;

--
-- Name: statustype; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.statustype AS ENUM (
    'Project',
    'Resource Pool',
    'Left'
);


ALTER TYPE public.statustype OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: medicine; Type: TABLE; Schema: dentalschema; Owner: admin
--

CREATE TABLE dentalschema.medicine (
    medicineid bigint NOT NULL,
    name text
);


ALTER TABLE dentalschema.medicine OWNER TO admin;

--
-- Name: dentalmedicine; Type: VIEW; Schema: dentalschema; Owner: admin
--

CREATE VIEW dentalschema.dentalmedicine AS
 SELECT medicine.medicineid,
    medicine.name
   FROM dentalschema.medicine;


ALTER TABLE dentalschema.dentalmedicine OWNER TO admin;

--
-- Name: dentalmedicine_new; Type: VIEW; Schema: dentalschema; Owner: admin
--

CREATE VIEW dentalschema.dentalmedicine_new AS
 SELECT medicine.medicineid,
    medicine.name
   FROM dentalschema.medicine;


ALTER TABLE dentalschema.dentalmedicine_new OWNER TO admin;

--
-- Name: dentalmedicine_new_new; Type: VIEW; Schema: dentalschema; Owner: admin
--

CREATE VIEW dentalschema.dentalmedicine_new_new AS
 SELECT medicine.medicineid,
    medicine.name
   FROM dentalschema.medicine;


ALTER TABLE dentalschema.dentalmedicine_new_new OWNER TO admin;

--
-- Name: medicine_medicineid_seq; Type: SEQUENCE; Schema: dentalschema; Owner: admin
--

CREATE SEQUENCE dentalschema.medicine_medicineid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dentalschema.medicine_medicineid_seq OWNER TO admin;

--
-- Name: medicine_medicineid_seq; Type: SEQUENCE OWNED BY; Schema: dentalschema; Owner: admin
--

ALTER SEQUENCE dentalschema.medicine_medicineid_seq OWNED BY dentalschema.medicine.medicineid;


--
-- Name: address; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.address (
    address_id bigint NOT NULL,
    door_no character varying(5),
    street_name character varying(100),
    city character varying(100),
    state character varying(100),
    pincode integer,
    mobile_no_fk bigint
);


ALTER TABLE public.address OWNER TO admin;

--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_address_id_seq OWNER TO admin;

--
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.address_address_id_seq OWNED BY public.address.address_id;


--
-- Name: appointment; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.appointment (
    appointment_id bigint NOT NULL,
    patient_mobile_no_fk bigint,
    appointment_day public.day,
    from_time timestamp without time zone,
    to_time timestamp with time zone,
    doctor_mobile_no_fk bigint
);


ALTER TABLE public.appointment OWNER TO admin;

--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.appointment_appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_appointment_id_seq OWNER TO admin;

--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.appointment_appointment_id_seq OWNED BY public.appointment.appointment_id;


--
-- Name: billseq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.billseq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999999
    CACHE 20;


ALTER TABLE public.billseq OWNER TO admin;

--
-- Name: bill; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.bill (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    appointment_id_fk bigint NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.bill OWNER TO admin;

--
-- Name: bill_appointment_id_fk_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.bill_appointment_id_fk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bill_appointment_id_fk_seq OWNER TO admin;

--
-- Name: bill_appointment_id_fk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.bill_appointment_id_fk_seq OWNED BY public.bill.appointment_id_fk;


--
-- Name: billview; Type: MATERIALIZED VIEW; Schema: public; Owner: admin
--

CREATE MATERIALIZED VIEW public.billview AS
 SELECT bill.bill_no,
    bill.treatment_type,
    bill.cost
   FROM public.bill
  WITH NO DATA;


ALTER TABLE public.billview OWNER TO admin;

--
-- Name: clinictransaction; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.clinictransaction (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
)
PARTITION BY RANGE (bill_no);


ALTER TABLE public.clinictransaction OWNER TO admin;

--
-- Name: dental_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dental_user (
    username text,
    password text,
    roles jsonb,
    userid uuid DEFAULT public.uuid_generate_v4()
);


ALTER TABLE public.dental_user OWNER TO admin;

--
-- Name: doctor; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.doctor (
    doctor_mobileno bigint NOT NULL,
    firstname character varying(100),
    lastname character varying(100),
    dob date,
    doctor_gender public.gender,
    remember_me boolean,
    regno text,
    specialization text,
    CONSTRAINT doctor_mobile_check CHECK (((doctor_mobileno > '7000000001'::bigint) AND (doctor_mobileno < '9999999999'::bigint)))
);


ALTER TABLE public.doctor OWNER TO admin;

--
-- Name: donor; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.donor (
    donorid bigint NOT NULL,
    donorname public.fullname
);


ALTER TABLE public.donor OWNER TO admin;

--
-- Name: donor_donorid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.donor_donorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donor_donorid_seq OWNER TO admin;

--
-- Name: donor_donorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.donor_donorid_seq OWNED BY public.donor.donorid;


--
-- Name: employee; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee (
    employee_no integer NOT NULL,
    name character varying(100),
    status public.statustype
)
PARTITION BY LIST (status);


ALTER TABLE public.employee OWNER TO admin;

--
-- Name: employee_employee_no_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.employee_employee_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_employee_no_seq OWNER TO admin;

--
-- Name: employee_employee_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.employee_employee_no_seq OWNED BY public.employee.employee_no;


--
-- Name: employee_left; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_left (
    employee_no integer DEFAULT nextval('public.employee_employee_no_seq'::regclass) NOT NULL,
    name character varying(100),
    status public.statustype
);


ALTER TABLE public.employee_left OWNER TO admin;

--
-- Name: employee_project; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_project (
    employee_no integer DEFAULT nextval('public.employee_employee_no_seq'::regclass) NOT NULL,
    name character varying(100),
    status public.statustype
);


ALTER TABLE public.employee_project OWNER TO admin;

--
-- Name: employee_rp; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.employee_rp (
    employee_no integer DEFAULT nextval('public.employee_employee_no_seq'::regclass) NOT NULL,
    name character varying(100),
    status public.statustype
);


ALTER TABLE public.employee_rp OWNER TO admin;

--
-- Name: hospital; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.hospital (
    hospitaldata xml
);


ALTER TABLE public.hospital OWNER TO admin;

--
-- Name: networkdata; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.networkdata (
    inetaddr inet
);


ALTER TABLE public.networkdata OWNER TO admin;

--
-- Name: patient; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.patient (
    mobileno bigint NOT NULL,
    firstname character varying(100),
    lastname character varying(100),
    dob date,
    patient_gender public.gender,
    remember_me boolean,
    email text
);


ALTER TABLE public.patient OWNER TO admin;

--
-- Name: prescription; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.prescription (
    prescription_id bigint NOT NULL,
    doctor_mobileno_fk bigint,
    patient_mobileno_fk bigint,
    appointment_id_fk bigint NOT NULL,
    prescription_info public.hstore
);


ALTER TABLE public.prescription OWNER TO admin;

--
-- Name: prescription_appointment_id_fk_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.prescription_appointment_id_fk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescription_appointment_id_fk_seq OWNER TO admin;

--
-- Name: prescription_appointment_id_fk_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.prescription_appointment_id_fk_seq OWNED BY public.prescription.appointment_id_fk;


--
-- Name: prescription_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.prescription_prescription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prescription_prescription_id_seq OWNER TO admin;

--
-- Name: prescription_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.prescription_prescription_id_seq OWNED BY public.prescription.prescription_id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    room character varying(5) NOT NULL,
    dates daterange NOT NULL
);


ALTER TABLE public.reservations OWNER TO admin;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO admin;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: tran_first; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tran_first (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.tran_first OWNER TO admin;

--
-- Name: tran_five; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tran_five (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.tran_five OWNER TO admin;

--
-- Name: tran_four; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tran_four (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.tran_four OWNER TO admin;

--
-- Name: tran_three; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tran_three (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.tran_three OWNER TO admin;

--
-- Name: tran_two; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tran_two (
    bill_no numeric DEFAULT nextval('public.billseq'::regclass) NOT NULL,
    treatment_type text,
    cost integer
);


ALTER TABLE public.tran_two OWNER TO admin;

--
-- Name: t1; Type: TABLE; Schema: s1; Owner: admin
--

CREATE TABLE s1.t1 (
    id integer
);


ALTER TABLE s1.t1 OWNER TO admin;

--
-- Name: t11; Type: VIEW; Schema: s1; Owner: admin
--

CREATE VIEW s1.t11 AS
 SELECT t1.id
   FROM s1.t1;


ALTER TABLE s1.t11 OWNER TO admin;

--
-- Name: employee_left; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee ATTACH PARTITION public.employee_left FOR VALUES IN ('Left');


--
-- Name: employee_project; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee ATTACH PARTITION public.employee_project FOR VALUES IN ('Project');


--
-- Name: employee_rp; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee ATTACH PARTITION public.employee_rp FOR VALUES IN ('Resource Pool');


--
-- Name: tran_first; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction ATTACH PARTITION public.tran_first FOR VALUES FROM (MINVALUE) TO ('250');


--
-- Name: tran_five; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction ATTACH PARTITION public.tran_five FOR VALUES FROM ('1501') TO ('2000');


--
-- Name: tran_four; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction ATTACH PARTITION public.tran_four FOR VALUES FROM ('1001') TO ('1500');


--
-- Name: tran_three; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction ATTACH PARTITION public.tran_three FOR VALUES FROM ('501') TO ('1000');


--
-- Name: tran_two; Type: TABLE ATTACH; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction ATTACH PARTITION public.tran_two FOR VALUES FROM ('251') TO ('500');


--
-- Name: medicine medicineid; Type: DEFAULT; Schema: dentalschema; Owner: admin
--

ALTER TABLE ONLY dentalschema.medicine ALTER COLUMN medicineid SET DEFAULT nextval('dentalschema.medicine_medicineid_seq'::regclass);


--
-- Name: address address_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_address_id_seq'::regclass);


--
-- Name: appointment appointment_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointment ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment_appointment_id_seq'::regclass);


--
-- Name: bill appointment_id_fk; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bill ALTER COLUMN appointment_id_fk SET DEFAULT nextval('public.bill_appointment_id_fk_seq'::regclass);


--
-- Name: donor donorid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.donor ALTER COLUMN donorid SET DEFAULT nextval('public.donor_donorid_seq'::regclass);


--
-- Name: employee employee_no; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.employee ALTER COLUMN employee_no SET DEFAULT nextval('public.employee_employee_no_seq'::regclass);


--
-- Name: prescription prescription_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription ALTER COLUMN prescription_id SET DEFAULT nextval('public.prescription_prescription_id_seq'::regclass);


--
-- Name: prescription appointment_id_fk; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription ALTER COLUMN appointment_id_fk SET DEFAULT nextval('public.prescription_appointment_id_fk_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Data for Name: medicine; Type: TABLE DATA; Schema: dentalschema; Owner: admin
--

COPY dentalschema.medicine (medicineid, name) FROM stdin;
\.


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.address (address_id, door_no, street_name, city, state, pincode, mobile_no_fk) FROM stdin;
\.


--
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.appointment (appointment_id, patient_mobile_no_fk, appointment_day, from_time, to_time, doctor_mobile_no_fk) FROM stdin;
1	9952032862	Monday	2023-02-27 18:00:00.37584	2023-02-27 19:00:00.37584+05:30	8056010299
\.


--
-- Data for Name: bill; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.bill (bill_no, appointment_id_fk, treatment_type, cost) FROM stdin;
1000	1	Implant	45000
5000	1	extraction	500
5001	1	filling	700
5002	1	rct	1500
1020	1	Metal Cap	15000
5010	1	8thextraction	500
5011	1	metal_filling	700
5012	1	rct_filling	1500
\.


--
-- Data for Name: dental_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dental_user (username, password, roles, userid) FROM stdin;
eswaribala	Test@123	[{"roleName": "ROLE_USER"}, {"roleName": "ROLE_ADMIN"}]	d36f0c74-3b94-47e0-a39f-fbc274695342
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.doctor (doctor_mobileno, firstname, lastname, dob, doctor_gender, remember_me, regno, specialization) FROM stdin;
8056010299	Vignesh	Bala	1995-12-07	Male	t	MDS23858	Prosthodontics
\.


--
-- Data for Name: donor; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.donor (donorid, donorname) FROM stdin;
1	(Parameswari,"",Bala)
\.


--
-- Data for Name: employee_left; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_left (employee_no, name, status) FROM stdin;
4	Arun	Left
\.


--
-- Data for Name: employee_project; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_project (employee_no, name, status) FROM stdin;
1	Parameswari	Project
2	Bala	Project
\.


--
-- Data for Name: employee_rp; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.employee_rp (employee_no, name, status) FROM stdin;
3	Vignesh	Resource Pool
\.


--
-- Data for Name: hospital; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.hospital (hospitaldata) FROM stdin;
<hospitals>\n <hospital>\n<name>Apollo Dental Clinic</name>\n<address>Chennai</address>\n</hospital>\n<hospital>\n<name>VEB Dental Clinic</name>\n<address>Chennai</address>\n</hospital>\n</hospitals>\n
<hospitals>\n <hospital>\n<name>VEL Dental Clinic</name>\n<address>Chennai</address>\n</hospital>\n<hospital>\n<name>32 Dental Clinic</name>\n<address>Chennai</address>\n</hospital>\n</hospitals>\n
\.


--
-- Data for Name: networkdata; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.networkdata (inetaddr) FROM stdin;
192.169.0.0
192.168.0.0/24
192.168.0.2
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.patient (mobileno, firstname, lastname, dob, patient_gender, remember_me, email) FROM stdin;
9952032862	Parameswari	Bala	1970-04-05	Female	t	parameswaribala@gmail.com
8056050425	Bala	Manick	1965-04-27	Male	t	bala@gmail.com
\.


--
-- Data for Name: prescription; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.prescription (prescription_id, doctor_mobileno_fk, patient_mobileno_fk, appointment_id_fk, prescription_info) FROM stdin;
1	8056010299	9952032862	1	"notes"=>"Any inconvenience immediately visit", "dosage"=>"500", "duration"=>"2 days", "frequency"=>"1-0-1", "medicine_name"=>"Dolo500"
2	8056010299	9952032862	1	"notes"=>"Any inconvenience immediately visit", "dosage"=>"250", "duration"=>"2 days", "frequency"=>"1-0-1", "medicine_name"=>"Paracetamol"
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reservations (id, room, dates) FROM stdin;
1	501	[2023-03-23,2023-03-26)
\.


--
-- Data for Name: tran_first; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tran_first (bill_no, treatment_type, cost) FROM stdin;
\.


--
-- Data for Name: tran_five; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tran_five (bill_no, treatment_type, cost) FROM stdin;
\.


--
-- Data for Name: tran_four; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tran_four (bill_no, treatment_type, cost) FROM stdin;
1022	RCT	3000
1023	8th Tooth Extraction	4000
1024	Braces	30000
\.


--
-- Data for Name: tran_three; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tran_three (bill_no, treatment_type, cost) FROM stdin;
\.


--
-- Data for Name: tran_two; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tran_two (bill_no, treatment_type, cost) FROM stdin;
\.


--
-- Data for Name: t1; Type: TABLE DATA; Schema: s1; Owner: admin
--

COPY s1.t1 (id) FROM stdin;
\.


--
-- Name: medicine_medicineid_seq; Type: SEQUENCE SET; Schema: dentalschema; Owner: admin
--

SELECT pg_catalog.setval('dentalschema.medicine_medicineid_seq', 1, false);


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.address_address_id_seq', 1, false);


--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.appointment_appointment_id_seq', 1, true);


--
-- Name: bill_appointment_id_fk_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.bill_appointment_id_fk_seq', 1, false);


--
-- Name: billseq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.billseq', 1039, true);


--
-- Name: donor_donorid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.donor_donorid_seq', 1, true);


--
-- Name: employee_employee_no_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.employee_employee_no_seq', 4, true);


--
-- Name: prescription_appointment_id_fk_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.prescription_appointment_id_fk_seq', 1, false);


--
-- Name: prescription_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.prescription_prescription_id_seq', 2, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reservations_id_seq', 1, true);


--
-- Name: address address_id_pk; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_id_pk PRIMARY KEY (address_id);


--
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);


--
-- Name: bill bill_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_pkey PRIMARY KEY (bill_no);


--
-- Name: clinictransaction clinictransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.clinictransaction
    ADD CONSTRAINT clinictransaction_pkey PRIMARY KEY (bill_no);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (doctor_mobileno);


--
-- Name: doctor doctor_regno_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_regno_key UNIQUE (regno);


--
-- Name: patient email_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (mobileno);


--
-- Name: prescription prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_pkey PRIMARY KEY (prescription_id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: tran_first tran_first_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tran_first
    ADD CONSTRAINT tran_first_pkey PRIMARY KEY (bill_no);


--
-- Name: tran_five tran_five_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tran_five
    ADD CONSTRAINT tran_five_pkey PRIMARY KEY (bill_no);


--
-- Name: tran_four tran_four_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tran_four
    ADD CONSTRAINT tran_four_pkey PRIMARY KEY (bill_no);


--
-- Name: tran_three tran_three_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tran_three
    ADD CONSTRAINT tran_three_pkey PRIMARY KEY (bill_no);


--
-- Name: tran_two tran_two_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tran_two
    ADD CONSTRAINT tran_two_pkey PRIMARY KEY (bill_no);


--
-- Name: billhashindex; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX billhashindex ON public.bill USING hash (treatment_type);


--
-- Name: billindex; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX billindex ON public.bill USING btree (cost);


--
-- Name: billpartialindex; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX billpartialindex ON public.bill USING brin (cost) WHERE (cost >= 10000);


--
-- Name: tran_first_pkey; Type: INDEX ATTACH; Schema: public; Owner: admin
--

ALTER INDEX public.clinictransaction_pkey ATTACH PARTITION public.tran_first_pkey;


--
-- Name: tran_five_pkey; Type: INDEX ATTACH; Schema: public; Owner: admin
--

ALTER INDEX public.clinictransaction_pkey ATTACH PARTITION public.tran_five_pkey;


--
-- Name: tran_four_pkey; Type: INDEX ATTACH; Schema: public; Owner: admin
--

ALTER INDEX public.clinictransaction_pkey ATTACH PARTITION public.tran_four_pkey;


--
-- Name: tran_three_pkey; Type: INDEX ATTACH; Schema: public; Owner: admin
--

ALTER INDEX public.clinictransaction_pkey ATTACH PARTITION public.tran_three_pkey;


--
-- Name: tran_two_pkey; Type: INDEX ATTACH; Schema: public; Owner: admin
--

ALTER INDEX public.clinictransaction_pkey ATTACH PARTITION public.tran_two_pkey;


--
-- Name: address address_mobile_no_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_mobile_no_fk_fkey FOREIGN KEY (mobile_no_fk) REFERENCES public.patient(mobileno);


--
-- Name: appointment appointment_doctor_mobile_no_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_doctor_mobile_no_fk_fkey FOREIGN KEY (doctor_mobile_no_fk) REFERENCES public.doctor(doctor_mobileno);


--
-- Name: appointment appointment_patient_mobile_no_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_patient_mobile_no_fk_fkey FOREIGN KEY (patient_mobile_no_fk) REFERENCES public.patient(mobileno);


--
-- Name: bill bill_appointment_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.bill
    ADD CONSTRAINT bill_appointment_id_fk_fkey FOREIGN KEY (appointment_id_fk) REFERENCES public.appointment(appointment_id);


--
-- Name: prescription prescription_appointment_id_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_appointment_id_fk_fkey FOREIGN KEY (appointment_id_fk) REFERENCES public.appointment(appointment_id);


--
-- Name: prescription prescription_doctor_mobileno_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_doctor_mobileno_fk_fkey FOREIGN KEY (doctor_mobileno_fk) REFERENCES public.doctor(doctor_mobileno);


--
-- Name: prescription prescription_patien_mobileno_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.prescription
    ADD CONSTRAINT prescription_patien_mobileno_fk_fkey FOREIGN KEY (patient_mobileno_fk) REFERENCES public.patient(mobileno);


--
-- Name: billview; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: admin
--

REFRESH MATERIALIZED VIEW public.billview;


--
-- PostgreSQL database dump complete
--

