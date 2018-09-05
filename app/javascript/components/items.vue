<template>
  <div>
    <ul>
      <li v-for="(item, index) in items" :key="index">
        {{ item }}
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
  methods: {
    add: function () {
      let vm = this;
      vm.items.push(vm.newItem)
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
