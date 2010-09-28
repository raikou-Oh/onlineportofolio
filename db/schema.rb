# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100902232827) do

  create_table "certifications", :force => true do |t|
    t.string  "resume_id", :limit => 10,                                       :null => false
    t.string  "judul",     :limit => 200
    t.string  "oleh",      :limit => 50
    t.integer "tahun",                           :precision => 4, :scale => 0
    t.binary  "file",      :limit => 2147483647
    t.text    "deskripsi"
  end

  create_table "education_histories", :force => true do |t|
    t.string  "resume_id",    :limit => 10,                               :null => false
    t.string  "nama_sekolah", :limit => 50
    t.integer "tingkat"
    t.decimal "nilai",                      :precision => 4, :scale => 2
    t.integer "akhir",                      :precision => 4, :scale => 0
    t.integer "awal",                       :precision => 4, :scale => 0
  end

  create_table "generals", :force => true do |t|
    t.string  "resume_id", :limit => 10,                                :null => false
    t.string  "judul",     :limit => 200,                               :null => false
    t.integer "tahun",                    :precision => 4, :scale => 0, :null => false
    t.text    "deskripsi"
  end

  create_table "languages", :force => true do |t|
    t.string "language", :limit => 50
    t.string "tipe",     :limit => 15
  end

  create_table "languages_resumes", :id => false, :force => true do |t|
    t.integer "language_id",              :null => false
    t.integer "resume_id",   :limit => 8, :null => false
  end

  create_table "message_groups", :force => true do |t|
    t.string "user_id", :limit => 10, :null => false
    t.string "nama",    :limit => 50
  end

  create_table "messages", :force => true do |t|
    t.string   "user_id",      :limit => 10
    t.string   "use_user_id",  :limit => 10,  :null => false
    t.string   "msgroup_id",   :limit => 10
    t.string   "subjek",       :limit => 100
    t.datetime "created_at"
    t.text     "pesan"
    t.boolean  "star"
    t.boolean  "unread"
    t.boolean  "senderdelete"
    t.boolean  "readerdelete"
  end

  create_table "offers", :force => true do |t|
    t.string   "user_id",    :limit => 10
    t.datetime "created_at"
    t.text     "email",      :limit => 2147483647
    t.text     "pesan"
    t.string   "subjek",     :limit => 100
  end

  create_table "pfiles", :force => true do |t|
    t.string  "project_id", :limit => 10,         :null => false
    t.string  "judul",      :limit => 200
    t.binary  "file",       :limit => 2147483647
    t.string  "filetype",   :limit => 25
    t.text    "deskripsi"
    t.boolean "flag"
  end

  create_table "pfiles_reviews", :id => false, :force => true do |t|
    t.integer  "user_id",    :limit => 8,                               :null => false
    t.integer  "file_id",    :limit => 8,                               :null => false
    t.text     "review"
    t.integer  "rating",     :limit => 2, :precision => 2, :scale => 0
    t.datetime "created_at"
  end

  create_table "projects", :force => true do |t|
    t.string  "user_id",         :limit => 10,                                       :null => false
    t.string  "judul",           :limit => 200
    t.string  "perusahaan",      :limit => 30
    t.integer "lama_pengerjaan", :limit => 2,          :precision => 2, :scale => 0
    t.string  "url",             :limit => 100
    t.string  "job_desc",        :limit => 30
    t.binary  "project_file",    :limit => 2147483647
    t.string  "content_type",    :limit => 50
    t.text    "deskripsi"
  end

  create_table "projects_reviews", :id => false, :force => true do |t|
    t.integer  "user_id",    :limit => 8,                               :null => false
    t.integer  "project_id", :limit => 8,                               :null => false
    t.text     "review"
    t.integer  "rating",     :limit => 2, :precision => 2, :scale => 0
    t.datetime "created_at"
  end

  create_table "projects_tools", :id => false, :force => true do |t|
    t.integer "tool_id",                 :null => false
    t.integer "project_id", :limit => 8, :null => false
  end

  create_table "resumes", :force => true do |t|
    t.string  "user_id",       :limit => 10,                                        :null => false
    t.string  "nama",          :limit => 50
    t.text    "alamat",        :limit => 2147483647
    t.date    "tanggal_lahir"
    t.string  "kota",          :limit => 30
    t.string  "telepon",       :limit => 15
    t.integer "kode_pos",      :limit => 5,          :precision => 5,  :scale => 0
    t.string  "marital",       :limit => 1
    t.string  "jenis_kelamin", :limit => 1
    t.string  "bidang",        :limit => 20
    t.binary  "file",          :limit => 2147483647
    t.boolean "edited"
    t.integer "pengalaman",    :limit => 2,          :precision => 2,  :scale => 0
    t.text    "deskripsi"
    t.integer "gaji",          :limit => 15,         :precision => 15, :scale => 0
    t.binary  "foto"
    t.string  "content_type",  :limit => 25
  end

  create_table "resumes_tools", :id => false, :force => true do |t|
    t.integer "tool_id",                :null => false
    t.integer "resume_id", :limit => 8, :null => false
  end

  create_table "templates", :force => true do |t|
    t.string   "content_type", :limit => 25
    t.string   "thumb",        :limit => 25
    t.binary   "data"
    t.datetime "created_at"
  end

  create_table "tools", :force => true do |t|
    t.string "nama_tool", :limit => 30
    t.string "fungsi",    :limit => 30
    t.string "versi",     :limit => 10
  end

  create_table "users", :force => true do |t|
    t.string   "template_id", :limit => 5,  :null => false
    t.string   "username",    :limit => 15
    t.string   "pass"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activated"
    t.boolean  "open_resume"
    t.boolean  "info_exp"
    t.boolean  "message"
    t.string   "salt"
    t.boolean  "admin"
  end

  create_table "work_histories", :force => true do |t|
    t.string  "resume_id",  :limit => 10,                               :null => false
    t.integer "awal",                     :precision => 4, :scale => 0
    t.integer "akhir",                    :precision => 4, :scale => 0
    t.string  "perusahaan", :limit => 30
    t.string  "posisi",     :limit => 10
    t.string  "bidang",     :limit => 20
  end

end
