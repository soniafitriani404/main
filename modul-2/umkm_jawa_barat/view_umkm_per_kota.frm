TYPE=VIEW
query=select `kk`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,count(`u`.`id_umkm`) AS `jumlah_umkm` from (`umkm_jawa_barat`.`kabupaten_kota` `kk` left join `umkm_jawa_barat`.`umkm` `u` on(`kk`.`id_kabupaten_kota` = `u`.`id_kabupaten_kota`)) group by `kk`.`id_kabupaten_kota`
md5=8ba7f2f7a11652f4632022d6f883510f
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744958319513158
create-version=2
source=SELECT \n    kk.nama_kabupaten_kota,\n    COUNT(u.id_umkm) AS jumlah_umkm\nFROM kabupaten_kota kk\nLEFT JOIN umkm u ON kk.id_kabupaten_kota = u.id_kabupaten_kota\nGROUP BY kk.id_kabupaten_kota
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `kk`.`nama_kabupaten_kota` AS `nama_kabupaten_kota`,count(`u`.`id_umkm`) AS `jumlah_umkm` from (`umkm_jawa_barat`.`kabupaten_kota` `kk` left join `umkm_jawa_barat`.`umkm` `u` on(`kk`.`id_kabupaten_kota` = `u`.`id_kabupaten_kota`)) group by `kk`.`id_kabupaten_kota`
mariadb-version=100432
