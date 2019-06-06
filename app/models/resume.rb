class Resume < ApplicationRecord
	#mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
	mount_uploaders :attachments, AttachmentUploader
end
