class MyFeature < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end
  alias :included :registered
end

::Middleman::Extensions.register(:my_feature, MyFeature)
