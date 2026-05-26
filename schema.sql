-- ==========================================
-- SKEMA DATABASE SUPABASE - SATIN JEMBRANA
-- Satuan Inti PMR Wira Jembrana
-- ==========================================

-- 1. Tabel Sesi Absensi
CREATE TABLE IF NOT EXISTS public.satin_absensi_sesi (
    id TEXT PRIMARY KEY,
    nama TEXT NOT NULL,
    tanggal TEXT NOT NULL,
    "poinSesi" INTEGER DEFAULT 10,
    aktif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.satin_absensi_sesi ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_absensi_sesi FOR SELECT USING (true);
CREATE POLICY "Allow admin write" ON public.satin_absensi_sesi FOR ALL USING (true);

-- 2. Tabel Presensi Submit (Pendaftar)
CREATE TABLE IF NOT EXISTS public.satin_absensi_submit (
    id TEXT PRIMARY KEY,
    sesi_id TEXT REFERENCES public.satin_absensi_sesi(id) ON DELETE CASCADE,
    nama_member TEXT NOT NULL,
    waktu TEXT NOT NULL,
    foto_bukti TEXT NOT NULL,
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_absensi_submit ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_absensi_submit FOR SELECT USING (true);
CREATE POLICY "Allow public insert" ON public.satin_absensi_submit FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow admin update" ON public.satin_absensi_submit FOR UPDATE USING (true);

-- 3. Tabel Sesi Penugasan
CREATE TABLE IF NOT EXISTS public.satin_penugasan_sesi (
    id TEXT PRIMARY KEY,
    judul TEXT NOT NULL,
    tanggal TEXT NOT NULL,
    deskripsi TEXT NOT NULL,
    ditugaskan_ke TEXT NOT NULL,
    poin_tugas INTEGER DEFAULT 15,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_penugasan_sesi ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_penugasan_sesi FOR SELECT USING (true);
CREATE POLICY "Allow admin write" ON public.satin_penugasan_sesi FOR ALL USING (true);

-- 4. Tabel Penugasan Submit (Bukti Serah Terima)
CREATE TABLE IF NOT EXISTS public.satin_penugasan_submit (
    id TEXT PRIMARY KEY,
    tugas_id TEXT REFERENCES public.satin_penugasan_sesi(id) ON DELETE CASCADE,
    nama_member TEXT NOT NULL,
    foto_bukti TEXT NOT NULL,
    status TEXT DEFAULT 'pending',
    tanggal_submit TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_penugasan_submit ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_penugasan_submit FOR SELECT USING (true);
CREATE POLICY "Allow public insert" ON public.satin_penugasan_submit FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow admin update" ON public.satin_penugasan_submit FOR UPDATE USING (true);

-- 5. Tabel Konfirmasi Kas (Ledger Kas Tunai)
CREATE TABLE IF NOT EXISTS public.satin_kas_konfirmasi (
    id TEXT PRIMARY KEY,
    nama_member TEXT NOT NULL,
    bulan TEXT NOT NULL,
    nominal INTEGER NOT NULL,
    foto_bukti TEXT DEFAULT 'cash',
    status TEXT DEFAULT 'approved',
    tanggal_submit TEXT NOT NULL,
    tipe TEXT DEFAULT 'cash',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_kas_konfirmasi ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_kas_konfirmasi FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON public.satin_kas_konfirmasi FOR ALL USING (true);

-- 6. Tabel Poin Tambahan (Bonus Poin)
CREATE TABLE IF NOT EXISTS public.satin_poin_tambahan (
    id TEXT PRIMARY KEY,
    nama_member TEXT NOT NULL,
    poin INTEGER NOT NULL,
    alasan TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_poin_tambahan ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_poin_tambahan FOR SELECT USING (true);
CREATE POLICY "Allow admin write" ON public.satin_poin_tambahan FOR ALL USING (true);

-- 7. Tabel Sandi Akses Relawan
CREATE TABLE IF NOT EXISTS public.satin_member_passcodes (
    nama_member TEXT PRIMARY KEY,
    passcode TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_member_passcodes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_member_passcodes FOR SELECT USING (true);
CREATE POLICY "Allow public write" ON public.satin_member_passcodes FOR ALL USING (true);

-- 8. Tabel Pengaturan Terpusat (Settings)
CREATE TABLE IF NOT EXISTS public.satin_settings (
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.satin_settings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.satin_settings FOR SELECT USING (true);
CREATE POLICY "Allow admin write" ON public.satin_settings FOR ALL USING (true);

-- Isi default pengaturan jika kosong
INSERT INTO public.satin_settings (key, value) 
VALUES 
    ('kasTarget', '10000'),
    ('cloudinaryCloudName', 'dui485svg'),
    ('cloudinaryUploadPreset', 'Satin-website')
ON CONFLICT (key) DO NOTHING;
