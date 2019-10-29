Sequel.migration do
  up do
    create_table(:reservations) do
      primary_key :id
      String :email, null: false, default: ""
      DateTime :reservation_date, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    alter_table(:reservations) { add_foreign_key :movie_id, :movies }
  end
end
