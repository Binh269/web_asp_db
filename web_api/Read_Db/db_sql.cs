using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace Read_Db
{
    public class db_sql
    {

        public string cnstr;
        public string get_status()
        {
            string json = "";
            try
            {

                using (SqlConnection conn = new SqlConnection(cnstr))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "SP_API";
                        cmd.Parameters.Add("@action", SqlDbType.VarChar, 50).Value = "get_infor";
                        object result = cmd.ExecuteScalar();
                        json = (string)result;
                    }
                }
            }
            catch
            {
                json = "{\"ok\":0,\"msg\":\"Lỗi rồi\"}";
            }

            return json;
        }

        public string update(int ma_thanh_vien, string vi_tri) 
        {
            string json = "";

            try
            {
                using (SqlConnection conn = new SqlConnection(cnstr))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "SP_API";
                        cmd.Parameters.Add("@action", SqlDbType.VarChar, 50).Value = "update";
                        cmd.Parameters.Add("@ma_thanh_vien", SqlDbType.Int).Value = ma_thanh_vien;
                        cmd.Parameters.Add("@vi_tri", SqlDbType.NVarChar).Value = vi_tri; 
                        object result = cmd.ExecuteScalar();
                        json = (string)result;
                    }
                }
            }
            catch (Exception ex) 
            {
                json = "{\"ok\":0,\"msg\":\"Lỗi rồi: " + ex.Message + "\"}";
            }

            return json;
        }


        public string get_history(int ma_thanh_vien)
        {
            string json = "";
            try
            {

                using (SqlConnection conn = new SqlConnection(cnstr))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "SP_API";
                        cmd.Parameters.Add("@action", SqlDbType.VarChar, 50).Value = "history";
                        cmd.Parameters.Add("@ma_thanh_vien", SqlDbType.Int).Value = ma_thanh_vien;
                        object result = cmd.ExecuteScalar();
                        json = (string)result;
                    }
                }
            }
            catch
            {
                json = "{\"ok\":0,\"msg\":\"Lỗi rồi\"}";
            }

            return json;
        }
        public string add_member(string ten, string vi_tri)
        {
            string json = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(cnstr))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "SP_API"; 
                        cmd.Parameters.Add("@action", SqlDbType.VarChar, 50).Value = "add";
                        cmd.Parameters.Add("@ten", SqlDbType.NVarChar).Value = ten;
                        cmd.Parameters.Add("@vi_tri", SqlDbType.NVarChar).Value = vi_tri;
                        object result = cmd.ExecuteScalar();
                        json = (string)result;
                    }
                }
            }
            catch
            {
                json = "{\"ok\":0,\"msg\":\"Lỗi rồi\"}";
            }
            return json;
        }

        public string delete_member(int ma_thanh_vien)
        {
            string json = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(cnstr))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "SP_API";
                        cmd.Parameters.Add("@action", SqlDbType.VarChar, 50).Value = "delete";
                        cmd.Parameters.Add("@ma_thanh_vien", SqlDbType.Int).Value = ma_thanh_vien;
                        object result = cmd.ExecuteScalar();
                        json = (string)result;
                    }
                }
            }
            catch (Exception ex) 
            {
                json = "{\"ok\":0,\"msg\":\"Lỗi rồi: " + ex.Message + "\"}";
            }
            return json;
        }

    }
}
