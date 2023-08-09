class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value != nil
      record.errors.add attribute, "Password must contain at least 1 upper letter" if value.match?(/^[^[A-Z]]*$/)
      record.errors.add attribute, "Password must contain at least 1 lower letter" if value.match?(/^[^[a-z]]*$/)
      record.errors.add attribute, "Password must contain at least 1  number" if value.match?(/^[^\d]*$/)
      record.errors.add attribute, "Password must contain at least 1 special character (@#$%!_)" if value.match?(/^[^[@#$%!_]]*$/)
      record.errors.add attribute, "Please match the password with above conditions" if value.match?(/[., ^&()-+\[\]{}"";'':``~|\\\/<>=]/)
    end
  end
end