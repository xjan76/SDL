from pathlib import Path
from mako.template import Template
import glob
import yaml

def read_yaml_from_file(file_path): 
  with open(file_path, 'r') as stream:
    return yaml.safe_load(stream)

def write_variables(content, path, output_path=None):
  mytemplate = Template(filename=path)
  result = mytemplate.render(config=content)
  if output_path is None:
    output_path = path.removesuffix('.tmpl')
  output_file = open(output_path, "w")
  output_file.write(result)
  output_file.close()

def create_inventory(template_path, enviroment_path, exercise_path):
  files = glob.glob(template_path)
  content = {
    "enviroment": read_yaml_from_file(enviroment_path),
    "exercise": read_yaml_from_file(exercise_path)
  }
  for file in files:
    write_variables(content, file)

def save_group_variables(ansible_path, config_path):
  files = glob.glob(ansible_path)
  configuration = read_yaml_from_file(config_path)
  for file in files:
    write_variables(configuration, file)

def save_host_vars(ansible_path, config_path):
  templates_paths = glob.glob(ansible_path)
  templates = list(map(lambda x: x.split("/").pop().split(".")[0], templates_paths))
  content = read_yaml_from_file(config_path)
  for virtual_machine in content.values():
    if virtual_machine['parent'] in templates:
      index = templates.index(virtual_machine['parent'])
      template_path = templates_paths[index]
      write_variables(virtual_machine, template_path, Path(template_path).parent.joinpath(virtual_machine['hostname'] + ".yml"))
    else:
      print("VM template unknown: " + virtual_machine['parent'])

save_group_variables("group_vars/*.tmpl", 'sdl_environment.yml') 
save_host_vars("host_vars/*.tmpl", 'sdl_exercise.yml') 
create_inventory("inventory.ini.tmpl", 'sdl_environment.yml', 'sdl_exercise.yml')