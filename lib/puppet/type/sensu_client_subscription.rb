Puppet::Type.newtype(:sensu_client_subscription) do
  @doc = ""

  def initialize(*args)
    super

    self[:notify] = [
      "Service[sensu-client]",
    ].select { |ref| catalog.resource(ref) }
  end

  ensurable do
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    defaultto :present
  end

  newparam(:name) do
    desc "The subscription name"
  end

  newproperty(:subscriptions) do
    desc "Subscriptions"
    defaultto :name
  end

  autorequire(:package) do
    ['sensu']
  end
end