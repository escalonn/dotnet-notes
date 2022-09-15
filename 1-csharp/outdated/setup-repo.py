from itertools import cycle
import json
from pathlib import Path
from pprint import pprint
import re
from slugify import slugify
from uuid import uuid4


# copy new guid to clipboard:
#   pwsh -c "new-guid | tee CON | set-clipboard"


def process_title(title):
    result = title
    # result = result.removeprefix(competency_prefix)
    result = title.replace('#', ' Sharp ')
    result = re.sub(r'\([^)]*\)', ' ', result)
    result = re.sub(r'($|\s).NET', r'\1dotnet', result)
    result = slugify(result)
    # print((title, result))
    return result


competency_prefix = 'C#:'
url_prefix = 'modules'
modules = []
with open('curriculum-csharp-foundations.yml') as f:
    for line in f:
        if line.startswith('#'):
            module_title = line[2:].strip()
            module = module_title, process_title(module_title), []
            modules.append(module)
        elif line.startswith('  - ') and not line.startswith('  -  '):
            topic_title = line[4:].strip()
            topic = topic_title, process_title(topic_title)
            modules[-1][2].append(topic)
modules = [m for m in modules if m[2]]
modules = [(t, f'{q + 1:03}-{s}',
    [(t, f'{q + 1:03}-{s}') for q, (t, s) in enumerate(l)])
    for q, (t, s, l) in enumerate(modules)]

orig_id_by_title = {}
# gather ids from existing file for keeping - comment this out if undesired
with open('navigation.json') as f:
    orig_navigation = json.load(f)
for module in orig_navigation['modules']:
    orig_id_by_title[module['title']] = module['id']
    for topic in module['topics']:
        orig_id_by_title[topic['title']] = topic['id']

# pprint(modules)
# pprint([(t, s, l) for (t, s, l) in modules])
modules_list = [{
    'id': orig_id_by_title.get(title, str(uuid4())),
    'title': title,
    'url': f'{url_prefix}/{slug}',
    'description': 'TODO: replace',
    'tooltip': 'TODO: replace',
    'prerequisites': {
        'url': f'{url_prefix}/{slug}/README',
        'title': 'Prerequisites and Learning Objectives',
        'tooltip': 'Prerequisites and Learning Objectives'
    },
    'topics': [{
        'id': orig_id_by_title.get(topic_title, str(uuid4())),
        'url': f'{url_prefix}/{slug}/{topic_slug}/Cumulative',
        'title': topic_title,
        'tooltip': topic_title
    } for (topic_title, topic_slug) in topics]
} for (title, slug, topics) in modules]
print(json.dumps(modules_list, indent='\t'))

# generate the files - uncomment if undesired
for (title, slug, topics) in modules:
    Path(f'{url_prefix}/{slug}').mkdir(parents=True)
    Path(f'{url_prefix}/{slug}/README').touch()
    for (topic_title, topic_slug) in topics:
        Path(f'{url_prefix}/{slug}/{topic_slug}').mkdir(parents=True)
        Path(f'{url_prefix}/{slug}/{topic_slug}/.gitkeep').touch()


#     # with open(f'{url_prefix}/{slug}/README','w') as f:
#         # '''
#         # ## Java

#         # ### Pre-Lecture Reading & Assignments
#         # These are specific resources for associates to use BEFORE coming to lecture - could be tutorials, videos, etc
#         # * [Example](./readme.md)

#         # ### List of Topics
#         # These are links to the lecture notes and other resources for the topics in this module
#         # * Java
#         #         *  [Introduction to java](./a-java-core/a-introduction-to-java/Cumulative.md)
#         #         *  [JDK-JRE-JVM](./a-java-core/b-jdk-jre-jvm/Cumulative.md)
#         #         *  [Helloworld](./a-java-core/c-helloworld/Cumulative.md)
#         #         *  [Class method Object instance variables](./a-java-core/d-class-method-object-instance-variables/Cumulative.md)
#         #         *   [Java basic syntax](./a-java-core/e-java-basic-syntax/Cumulative.md)
#         #         *    [stack and heap](./a-java-core/f-stack-and-heap/Cumulative.md)
#         #         *     [Garbage collection](./a-java-core/g-garbage-collection/Cumulative.md)
#         #         *      [Importance of readability](./a-java-core/h-importance-of-readability/Cumulative.md)
#         #         *       [comments and javadocs](./a-java-core/i-comments-and-javadocs/Cumulative.md)
#         #         *        [self-documenting-code](./a-java-core/j-self-documenting-code/Cumulative.md)

#         # * OOP
#         # *  [Introduction to OOP](./b-oop-concepts/Cumulative.md)
#         # '''
