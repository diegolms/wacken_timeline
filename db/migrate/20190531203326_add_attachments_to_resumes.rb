class AddAttachmentsToResumes < ActiveRecord::Migration[5.2]
  def change
    add_column :resumes, :attachments, :json
  end
end
