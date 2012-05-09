module ScrumConfig
  config = YAML.load_file("#{Rails.root}/config/config.yml")
  MAILING_LIST = config['mailing-list']
end
