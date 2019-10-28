Sequel.migration do
  up do 
    create_table(:movies) do
      primary_key :id
      String :name, null: false, default: ""
      String :description, null: false, default: ""
      String :url_image, null: false, default: ""
      DateTime :begin_date, null: false
      DateTime :finish_date, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
