<template>
  <div id="app">
    <v-app>
      <v-container class="search-container">
        <v-row>
          <v-btn icon id="author-login" href="/profile" target="_blank">
            Author Login
          </v-btn>
        </v-row>
        <v-row>
          <v-img id="search-logo" :src="require('./assets/library_logo.png')" :max-height="500" :max-width="500"/>
        </v-row>
        <v-row>
          <div id="search-bar">
            <v-text-field
                v-model="searchQuery"
                @input="fetchBooks"
                solo
                label="Search by title"
                clearable
            ></v-text-field>
          </div>
        </v-row>
        <v-row>
          <v-simple-table id="search-table">
            <template v-slot:default>
              <thead>
              <tr>
                <th class="text-left">
                  ID
                </th>
                <th class="text-left">
                  ISBN
                </th>
                <th class="text-left">
                  Title
                </th>
                <th class="text-left">
                  Publisher
                </th>
                <th class="text-left">
                  Publication Year
                </th>
                <th class="text-left">
                  Publication Location
                </th>
              </tr>
              </thead>
              <tbody>
              <tr
                  v-for="item in books"
                  :key="item.id"
              >
                <td>
                  <a target="_blank" :href="`localhost:3000/books/${item.id}`">
                    {{ item.id }}
                  </a>
                </td>
                <td>{{ item.isbn }}</td>
                <td>{{ item.title }}</td>
                <td>{{ item.publisher }}</td>
                <td>{{ item.publication_year }}</td>
                <td>{{ item.publication_country_code }}</td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-row>
      </v-container>
    </v-app>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      searchQuery: '',
      books: []
    }
  },
  mounted() {
    this.fetchBooks();
  },
  methods: {
    fetchBooks: function () {
      axios.get(`http://localhost:3000/search?search_query=${this.searchQuery}`, {headers: {'Accept': 'application/json'}}).then(response => {
        this.books = response.data;
      });
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

.search-container {
  margin-left: auto;
  margin-top: 5%;
  width: 100%;
  height: 100%;
}

#search-logo {
  margin-top: 1%;
  margin-left: auto;
  margin-right: auto;
  display: block;
  width: 50%;
}

#search-bar {
  margin-top: 1%;
  margin-left: auto;
  margin-right: auto;
  display: block;
  width: 60%;
}

#search-table {
  margin-top: 1%;
  margin-left: auto;
  margin-right: auto;
  display: block;
  width: 60%;
}

#author-login {
  margin-top: 1%;
  margin-left: auto;
  margin-right: auto;
  display: block;
}
</style>
