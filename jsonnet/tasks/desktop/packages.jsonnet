// GUI packages — parent desktop/main already gates on gui_workstations.
[
  {
    name: 'Install gui packages',
    package: {
      name: '{{ gui_packages }}',
      state: 'present',
    },
  },
]
