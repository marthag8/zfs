actions :create, :destroy

attribute :name, kind_of: String
attribute :mountpoint, kind_of: String, default: nil
attribute :zoned, kind_of: String, equal_to: %w(on off),  default: 'off'
attribute :recordsize, kind_of: String, default: '128K'
attribute :atime, kind_of: String, equal_to: %w(on off), default: 'on'
attribute :compression, kind_of: String, equal_to: ['on', 'off', 'lzjb', 'gzip', 'gzip-1', 'gzip-2', 'gzip-3', 'gzip-4', 'gzip-5', 'gzip-6', 'gzip-7', 'gzip-8', 'gzip-9', 'lz4'], default: 'off'
attribute :quota, kind_of: String, default: 'none'
attribute :refquota, kind_of: String, default: 'none'
attribute :reservation, kind_of: String, default: 'none'
attribute :refreservation, kind_of: String, default: 'none'
attribute :dedup, kind_of: String, equal_to: %w(on off), default: 'off'

attribute :info, kind_of: Mixlib::ShellOut, default: nil
attribute :current_props, kind_of: Hash, default: nil
attribute :desired_props, kind_of: Hash, default: nil

def initialize(*args)
  super
  @action = :create
  @mountpoint ||= '/' + name
end
