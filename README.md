[![Build Status](https://secure.travis-ci.org/marthag8/zfs.png)](http://travis-ci.org/marthag8/zfs)

Description
===========

Lightweight resource and provider to manage Solaris zfs file systems. 
Currently, only a limited sub-set of options are supported.

Requirements
============

Solaris, zfs.
Zpool should be already created, either manually or with the zpool LWRP.

Attributes
==========

    mountpoint  - defaults to /name
    zoned       - "on", "off" - defaults to "off"
    atime       - "on, "off", - defaults to "on"
    recordsize  - defaults to "128K"
    compression - "on", "off", "lzjb", "gzip", "gzip-1", "gzip-2", "gzip-3", "gzip-4", "gzip-5", "gzip-6", "gzip-7", "gzip-8", "gzip-9", "lz4" - defaults to "off"
 
Usage
=====

    zfs "zones/test" do
      action :create
      mountpoint "/opt/test"
    end
  
    zfs "test/test2" do
      zoned "on"
      atime "off"
      recordsize "16K"
      mountpoint "none"
      compression "lz4"
    end
  
    zfs "test/test3" do
      action :destroy
    end
