source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'zfs_test', path: './test/fixtures/zfs_test'
  cookbook 'chef_zpool', git: 'https://github.com/chef-cookbooks/zpool', branch: 'Issue-5/refactor-for-chef-13'
end
