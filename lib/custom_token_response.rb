module CustomTokenResponse
  def body
    user_id = @token.resource_owner_id

    additional_data = {
      'username' => User.find(user_id).username,
      'userid' => user_id
    }

    super.merge(additional_data)
  end
end
