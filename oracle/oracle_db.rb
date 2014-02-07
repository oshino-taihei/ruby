# coding: UTF-8
require 'oci8'

user='<DBユーザ>'
pass='<パスワード>'
tns='<TNS名>'
sql="select * from table"

begin
  conn = OCI8.new(user, pass, tns)
  cursor = conn.exec(sql)
  puts cursor.get_col_names.join(',')
  puts cursor.column_metadata
  while row = cursor.fetch
    puts row.join(',')
  end
  puts "#{cursor.row_count} rows fetched."

  cursor.close
  ensure
  conn.logoff if conn
end
