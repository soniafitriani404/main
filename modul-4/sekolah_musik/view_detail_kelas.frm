TYPE=VIEW
query=select `k`.`nama_kelas` AS `nama_kelas`,`g`.`nama_guru` AS `nama_guru`,`a`.`nama_alat` AS `nama_alat`,`k`.`durasi_jam` AS `durasi_jam`,`k`.`biaya` AS `biaya` from ((`sekolah_musik`.`kelasmusik` `k` join `sekolah_musik`.`guru` `g` on(`k`.`id_guru` = `g`.`id_guru`)) join `sekolah_musik`.`alatmusik` `a` on(`k`.`id_alat` = `a`.`id_alat`))
md5=6c7f75d2e63a01e103c683c66c25af12
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744963700473553
create-version=2
source=SELECT \n    k.nama_kelas,\n    g.nama_guru,\n    a.nama_alat,\n    k.durasi_jam,\n    k.biaya\nFROM KelasMusik k\nJOIN Guru g ON k.id_guru = g.id_guru\nJOIN AlatMusik a ON k.id_alat = a.id_alat
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `k`.`nama_kelas` AS `nama_kelas`,`g`.`nama_guru` AS `nama_guru`,`a`.`nama_alat` AS `nama_alat`,`k`.`durasi_jam` AS `durasi_jam`,`k`.`biaya` AS `biaya` from ((`sekolah_musik`.`kelasmusik` `k` join `sekolah_musik`.`guru` `g` on(`k`.`id_guru` = `g`.`id_guru`)) join `sekolah_musik`.`alatmusik` `a` on(`k`.`id_alat` = `a`.`id_alat`))
mariadb-version=100432
