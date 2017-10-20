#
# Cookbook Name:: zfs_test
# Recipe:: default
#
# Copyright (C) 2017 Ryan Hass
# Copyright (C) 2017 Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_update 'update' if platform_family?('debian')

package 'zfs' if platform?('ubuntu')

vdisks = []
# Create vdevs.
(0..3).each do |i|
  img = "/disk_#{i}.img"
  loopback = case node['platform']
             when 'ubuntu'
               "/dev/loop#{i}"
             when 'freebsd'
               "/dev/md#{i}"
             when 'solaris2'
               img
             else
               raise 'Unsupported Platform.'
             end

  execute "create_vdisk_#{i}" do
    command "dd if=/dev/zero of=#{img} bs=1024 count=65536"
    not_if { ::File.exist?(img) }
  end

  execute "create_loopback_device_#{i}" do
    command "losetup #{loopback} #{img}"
    not_if "losetup -a | grep -q #{img}"
    only_if { platform?('ubuntu') }
  end

  execute "create_loopback_device_#{i}" do
    command "mdconfig -a -t vnode -f #{img} -u #{i}"
    not_if "mdconfig -l | grep -q md#{i}"
    only_if { platform?('freebsd') }
  end

  vdisks << loopback
end

pool = zpool 'testpool' do
  disks vdisks
end

zfs "#{pool.name}/basic"

zfs "#{pool.name}/setprop" do
  properties [
    { utf8only: 'on' },
    { compression: 'lz4' },
  ]
end
