[
  {
    name: 'Check if lig is installed',
    stat: { path: '/usr/bin/lig' },
    register: 'lig_binary',
  },
  {
    name: 'Install lig',
    when: 'not lig_binary.stat.exists',
    block: [
      {
        name: 'Ensure apt keyrings directory',
        file: {
          path: '/etc/apt/keyrings',
          state: 'directory',
          mode: '0755',
        },
      },
      {
        name: 'Install apt key for lig',
        apt_key: {
          url: 'https://kevengoncalves.github.io/lig/apt/lig.gpg',
          keyring: '/etc/apt/keyrings/lig.gpg',
        },
      },
      {
        name: 'Add apt repository for lig',
        apt_repository: {
          repo: 'deb [signed-by=/etc/apt/keyrings/lig.gpg] https://kevengoncalves.github.io/lig/apt stable main',
          state: 'present',
        },
      },
      {
        name: 'Install lig package',
        apt: {
          name: 'lig',
          update_cache: true,
        },
      },
    ],
  },
]
