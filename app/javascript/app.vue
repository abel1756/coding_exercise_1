<template>
  <div id="app">
    <v-app>
      <v-container class="search-container">
        <v-row>
          <v-img id="search-logo" :src="require('./assets/library_logo.png')" :max-height="500" :max-width="500"/>
        </v-row>
        <v-row>
          <div id="search-bar">
            <v-text-field
                solo
                label="Search catalog by Title, Author, ISBN, ..."
                clearable
            ></v-text-field>
          </div>
        </v-row>
        <v-row align="center" justify="space-around">
          <v-btn id="search-button" color="info">
            Search
          </v-btn>
        </v-row>
      </v-container>
    </v-app>
  </div>
</template>

<script>
export default {
  data: function () {
    return {

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
</style>
