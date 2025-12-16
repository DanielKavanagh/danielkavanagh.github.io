---
layout: defaults/page
permalink: /
narrow: true
---

{% include components/intro.md %}

---

### Links

{% for item in site.data.nav %}
{% unless item.title == "Home" %}
[{{item.title}}](/{{item.href}})
{% endunless %}
{% endfor %}
