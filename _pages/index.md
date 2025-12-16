---
layout: defaults/page
permalink: /
narrow: true
---

{% include components/intro.md %}

---

### Recent Blog Posts

{% for post in site.posts limit:3 %}
{% include components/post-card.html %}
{% endfor %}


