TYPE=VIEW
query=select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`k`.`nama_kategori` AS `nama_kategori`,`s`.`nama_skala` AS `nama_skala`,`kk`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,`u`.`tahun_berdiri` AS `tahun_berdiri` from ((((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`kategori_umkm` `k` on(`u`.`id_kategori` = `k`.`id_kategori`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`kabupaten_kota` `kk` on(`u`.`id_kabupaten_kota` = `kk`.`id_kabupaten_kota`))
md5=70a826602eae57aff5a2182e7178b798
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744707194383284
create-version=2
source=SELECT \n    u.nama_usaha,\n    p.nama_lengkap AS nama_pemilik,\n    k.nama_kategori,\n    s.nama_skala,\n    kk.nama_kabupaten_kota,\n    u.tahun_berdiri\nFROM umkm u\nJOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik\nJOIN kategori_umkm k ON u.id_kategori = k.id_kategori\nJOIN skala_umkm s ON u.id_skala = s.id_skala\nJOIN kabupaten_kota kk ON u.id_kabupaten_kota = kk.id_kabupaten_kota
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`k`.`nama_kategori` AS `nama_kategori`,`s`.`nama_skala` AS `nama_skala`,`kk`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,`u`.`tahun_berdiri` AS `tahun_berdiri` from ((((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`kategori_umkm` `k` on(`u`.`id_kategori` = `k`.`id_kategori`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) join `umkm_jawa_barat`.`kabupaten_kota` `kk` on(`u`.`id_kabupaten_kota` = `kk`.`id_kabupaten_kota`))
mariadb-version=100432
