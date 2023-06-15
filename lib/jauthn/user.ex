defmodule Jauthn.User do
  @moduledoc false
  @table :jauthn_user_keys

  def init() do
    :dets.open_file(@table, [{:type, :bag}])
  end

  def register_new_cose_key(user_id, user, key_id, cose_key, maybe_aaguid) do
    # TOD0: check if the key_id is not already in use
    # bullet 18. https://www.w3.org/TR/2019/PR-webauthn-20190117/#registering-a-new-credential
    :dets.insert(@table, {user_id, user, key_id, cose_key, maybe_aaguid})
  end

  def get_by_user_id(user_id) do
    :dets.lookup(@table, user_id)
  end

  def get_by_username(username) do
    :dets.select(@table, [{{:_, :"$1", :_, :_, :_}, [{:==, :"$1", username}], [:"$_"]}])
  end

  def print_keys() do
    :dets.traverse(
      @table,
      fn entry ->
        IO.inspect(entry)
        :continue
      end
    )
  end

  def clean_keys() do
    :dets.delete_all_objects(@table)
  end
end
