<template>
  <div>
    <ul>
      <li v-for="(item, index) in items" :key="index">
        <input v-model="item.body">
        <button v-on:click="updateItem(item)">Update</button>
        <button v-on:click="deleteItem(item.id, index)">X</button>
        <button v-on:click="upvoteItem(item)">Upvote</button>
        {{ item.vote_count }}
        <button v-on:click="downvoteItem(item)">Downvote</button>
      </li>
    </ul>
    <input v-model="newItem" placeholder="Add new item...">
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
        vm.items.push({
          id: data.id,
          body: data.body,
          vote_count: data.vote_count
        })
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
    },
    upvoteItem: function (item) {
      fetch(`/items/${item.id}/upvote`, { method: 'POST' })
        .then((response) => response.json())
        .then((data) => item.vote_count = data.vote_count)
    },
    downvoteItem: function (item) {
      fetch(`/items/${item.id}/downvote`, { method: 'POST' })
        .then((response) => response.json())
        .then((data) => item.vote_count = data.vote_count)
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
