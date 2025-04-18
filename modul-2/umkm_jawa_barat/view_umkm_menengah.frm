TYPE=VIEW
query=select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`u`.`total_aset` AS `total_aset`,`u`.`omzet_per_tahun` AS `omzet_per_tahun` from ((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) where `s`.`nama_skala` = \'Menengah\'
md5=832bea220c1faf7f12d27d768e527db7
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744958023683177
create-version=2
source=SELECT \n    u.nama_usaha,\n    p.nama_lengkap AS nama_pemilik,\n    u.total_aset,\n    u.omzet_per_tahun\nFROM umkm u\nJOIN pemilik_umkm p ON u.id_pemilik = p.id_pemilik\nJOIN skala_umkm s ON u.id_skala = s.id_skala\nWHERE s.nama_skala = \'Menengah\'
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `u`.`nama_usaha` AS `nama_usaha`,`p`.`nama_lengkap` AS `nama_pemilik`,`u`.`total_aset` AS `total_aset`,`u`.`omzet_per_tahun` AS `omzet_per_tahun` from ((`umkm_jawa_barat`.`umkm` `u` join `umkm_jawa_barat`.`pemilik_umkm` `p` on(`u`.`id_pemilik` = `p`.`id_pemilik`)) join `umkm_jawa_barat`.`skala_umkm` `s` on(`u`.`id_skala` = `s`.`id_skala`)) where `s`.`nama_skala` = \'Menengah\'
mariadb-version=100432
