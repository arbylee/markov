require 'googleauth'
require 'googleauth/stores/file_token_store'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'

scope = 'https://www.googleapis.com/auth/drive'
client_id = Google::Auth::ClientId.from_file('client_secrets.json')
token_store = Google::Auth::Stores::FileTokenStore.new(
  :file => 'tokens.yaml')
authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)

credentials = authorizer.get_credentials(client_id)
if credentials.nil?
  url = authorizer.get_authorization_url(base_url: OOB_URI )
  puts "Open #{url} in your browser and enter the resulting code:"
  code = gets
  credentials = authorizer.get_and_store_credentials_from_code(
    user_id: user_id, code: code, base_url: OOB_URI)
end
