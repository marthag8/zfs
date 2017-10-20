[![Build Status](https://secure.travis-ci.org/marthag8/zfs.png)](http://travis-ci.org/marthag8/zfs)

Description
===========

Manage ZFS filesystems.

Requirements
============

A valid zpool. This can be managed with the zpool cookbook.

Properties
==========

 - `properties`: ZFS properties are set as an Hrray of Hashes to configure the filesystems using the single `properties` attribute.


Usage
=====

### Creating a ZFS Filesytem
```ruby
zfs "tank/test" do
  properties [
    { mountpoint: '/opt/test' },
    { relatime: 'on' },
    { compression: 'lz4' }
  ]
  action :create
end
```

### Upgrading a ZFS to the latest filesystem version:

```ruby
zfs "tank/test" do
  action :upgrade
end
```

```ruby
zfs "tank/test" do
  properties [
    { mountpoint: '/opt/test' },
    { relatime: 'on' },
    { compression: 'lz4' }
  ]
  action [:create, :upgrade]
end
```

### Destroying a ZFS Filesystem

```ruby
zfs "tank/test" do
  action :destroy
end
```

:sparkles: Note that destroy flags are not directly supported. However, some like the `-d` flag can be used by setting the `defer_destroy` property on the filesystem prior to desctruction. See the example below.

```ruby
filesystem = zfs "tank/test" do
  properties [
    { defer_destroy: 'on' }
  ]
  action :create
  only_if "zfs list | grep -q #{self.name}"
end

zfs filesystem.name do
  action :destroy
end
```
