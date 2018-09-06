<template>
  <div>
    <ul>
      <li v-for="(item, index) in items" :key="index">
        <input v-model="item.body">
        <button v-on:click="updateItem(item)">Update</button>
        <button v-on:click="deleteItem(item.id, index)">X</button>
      </li>
    </ul>
    <input v-model="newItem" placeholder="add...">
    <button v-on:click="addItem">Add</button>
  </div>
</template>

<script>
const headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
}

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
    addItem: function () {
      let vm = this;
      fetch('/items', {
          method: 'POST',
          body: JSON.stringify({ body: vm.newItem }),
          headers: headers })
      .then((response) => response.json())
      .then((data) => {
        vm.items.push({ id: data.id, body: data.body })
        vm.newItem = ''
      })
    },
    deleteItem: function (itemId, index) {
      fetch(`/items/${itemId}`, { method: 'DELETE' })
        .then(() => {
          this.items.splice(index, 1)
        })
    },
    updateItem: function (item) {
      fetch(`/items/${item.id}`, {
        method: 'PUT',
        body: JSON.stringify({ body: item.body}),
        headers: headers })
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
