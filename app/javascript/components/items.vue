<template>
  <div>
    <ul>
      <li v-for="(item, index) in items" :key="index">
        {{ item.body }}
      </li>
    </ul>
    <input v-model="newItem" placeholder="add...">
    <button v-on:click="add">Add</button>
  </div>
</template>

<script>

export default {
  data: () => {
    return {
      newItem: '',
      items: []
    }
  },

  created: function() {
    fetch('/items')
      .then((response) => response.json())
      .then((data) => this.items = data)
  },

  methods: {
    add: function () {
      let vm = this;
      vm.items.push({ body: vm.newItem })
      fetch('/items',
        {
          method: 'POST',
          body: JSON.stringify({ body: vm.newItem }),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }
        }
      )
      vm.newItem = ''
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
