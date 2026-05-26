# SATIN Jembrana - Database Schema (Supabase)

Repositori ini menyimpan skema database terpusat untuk **SATIN (Satuan Inti PMR Wira Jembrana)** yang di-host menggunakan **Supabase**.

## 🚀 Cara Setup Database di Supabase

Untuk menerapkan atau memperbarui struktur tabel di dashboard Supabase Anda, ikuti langkah-langkah berikut:

1. Masuk ke [Supabase Dashboard](https://supabase.com/).
2. Buka proyek Supabase Anda.
3. Di panel menu sebelah kiri, pilih **SQL Editor** -> klik **New Query**.
4. Salin seluruh konten dari berkas [`schema.sql`](./schema.sql) di repositori ini.
5. Tempel (*paste*) kode tersebut ke dalam editor SQL Supabase.
6. Klik tombol **Run** untuk membuat tabel dan kebijakan Row Level Security (RLS) secara otomatis.

## 📊 Daftar Tabel

| Nama Tabel | Deskripsi |
| :--- | :--- |
| `satin_absensi_sesi` | Menyimpan sesi absensi aktif yang dibuat oleh admin |
| `satin_absensi_submit` | Menyimpan kiriman bukti presensi kehadiran dari relawan |
| `satin_penugasan_sesi` | Menyimpan daftar penugasan (kelompok atau individu) dari admin |
| `satin_penugasan_submit` | Menyimpan bukti penyelesaian tugas yang dikirim oleh relawan |
| `satin_kas_konfirmasi` | Menyimpan catatan buku kas relawan (pembayaran tunai/cash) |
| `satin_poin_tambahan` | Menyimpan poin bonus khusus yang diberikan oleh admin kepada pengurus |
| `satin_member_passcodes` | Menyimpan passcode sandi akses masuk portal masing-masing anggota |
| `satin_settings` | Menyimpan konfigurasi global seperti target nominal kas bulanan |

---
*Dikelola secara otomatis oleh Antigravity AI Coding Assistant.*
