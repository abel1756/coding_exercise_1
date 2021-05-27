<template>
  <div id="app">
    <v-app>
      <v-app-bar id="profile-nav-bar" color="white">
        <v-tabs>
          <v-tab href="#profile">Profile</v-tab>
          <v-tab-item key="profile" id="profile" v-bind="currentAuthor">
            <v-container id="profile-container">
              <v-row>
                <v-text-field
                  v-model="currentAuthor.first_name"
                  label="First Name"
                  outlined
                  readonly
                ></v-text-field>
              </v-row>
              <v-row>
                <v-text-field
                    v-model="currentAuthor.last_name"
                    label="Last Name"
                    outlined
                    readonly
                ></v-text-field>
              </v-row>
              <v-row>
                <v-text-field
                    v-model="currentAuthor.email"
                    label="Email"
                    outlined
                    readonly
                ></v-text-field>
              </v-row>
            </v-container>
          </v-tab-item>
          <v-tab href="#books">Books</v-tab>
          <v-tab-item key="books" id="books">
            <v-container id="books-container">
              <v-row>
                <v-dialog
                    v-model="dialog"
                    persistent
                    max-width="600px"
                >
                  <template v-slot:activator="{ on, attrs }">
                    <v-btn
                        color="primary"
                        dark
                        v-bind="attrs"
                        v-on="on"
                    >
                      Add New Book
                    </v-btn>
                  </template>
                  <v-card>
                    <v-card-title>
                      <span class="headline">New Book</span>
                    </v-card-title>
                    <v-card-text>
                      <v-container>
                        <v-row>
                          <v-col cols="12">
                            <input type="file" id="file" ref="file" v-on:change="uploadCoverImage()"/>
                          </v-col>
                          <v-col cols="12">
                            <v-text-field
                                v-model="newBookISBN"
                                label="ISBN*"
                                required
                            ></v-text-field>
                          </v-col>
                          <v-col cols="12">
                            <v-text-field
                                v-model="newBookTitle"
                                label="Title*"
                                required
                            ></v-text-field>
                          </v-col>
                          <v-col cols="12">
                            <v-text-field
                                v-model="newBookPublisher"
                                label="Publisher*"
                                required
                            ></v-text-field>
                          </v-col>
                          <v-col cols="12">
                            <v-text-field
                                v-model="newBookPublicationYear"
                                label="Publication Year*"
                                required
                            ></v-text-field>
                          </v-col>
                          <v-col cols="12">
                            <v-text-field
                                v-model="newBookPublicationCountryCode"
                                label="Publication Country Code*"
                                required
                            ></v-text-field>
                          </v-col>
                        </v-row>
                      </v-container>
                      <small>*required field</small>
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn
                          color="red darken-1"
                          text
                          @click="dialog = false"
                      >
                        Close
                      </v-btn>
                      <v-btn
                          color="blue darken-1"
                          text
                          @click="createBook"
                      >
                        Save
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </v-dialog>
              </v-row>
              <v-row>
                <v-simple-table>
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
          </v-tab-item>
        </v-tabs>
      </v-app-bar>
    </v-app>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data: function () {
    return {
      dialog: false,
      newBookCoverImage: null,
      newBookISBN: null,
      newBookTitle: null,
      newBookPublisher: null,
      newBookPublicationYear: null,
      newBookPublicationCountryCode: null,
      currentAuthor: null,
      books: [],
      headers: [
        { text: 'ID', value: 'id' },
        { text: 'ISBN', value: 'isbn' },
        { text: 'Title', value: 'title' },
        { text: 'Publisher', value: 'publisher' },
        { text: 'Publication Year', value: 'publication_year' },
        { text: 'Publication Country Code', value: 'publication_country_code' }
      ]
    }
  },
  mounted() {
    axios.get("http://localhost:3000/profile", { headers: {'Accept': 'application/json'}}).then(response => {
      this.currentAuthor = response.data;
    });
    this.fetchBooks();
  },
  methods: {
    fetchBooks: function() {
      axios.get("http://localhost:3000/profile/books", { headers: {'Accept': 'application/json'}}).then(response => {
        this.books = response.data;
      });
    },
    uploadCoverImage: function() {
      this.newBookCoverImage = this.$refs.file.files[0];
    },
    createBook: function() {
      const token = document.querySelector('[name="csrf-token"]') || {content: 'no-csrf-token'};
      const headers = {
        'Content-Type': 'multipart/form-data',
        common: {
          'X-CSRF-Token': token.content
        }
      }
      let formData = new FormData();
      formData.append("cover_image", this.newBookCoverImage)
      formData.append("isbn", this.newBookISBN);
      formData.append("title", this.newBookTitle);
      formData.append("publisher", this.newBookPublisher);
      formData.append("publication_year", this.newBookPublicationYear);
      formData.append("publication_country_code", this.newBookPublicationCountryCode);
      axios
          .post("http://localhost:3000/books", formData, { headers: headers })
          .then(() => {
            this.dialog = false;
            this.fetchBooks();
          });
    }
  }
}
</script>

<style scoped>
#profile-nav-bar {
  margin-left: auto;
  margin-top: 5%;
  width: 100%;
  height: 100%;
}

#profile-container {
  margin-left: 10px;
  margin-top: 30px;
  width: 20%;
}

#books-container {
  margin-left: auto;
  margin-right: auto;
  margin-top: 30px;
  width: 100%;
}

#books-table {
  margin-left: auto;
  margin-right: auto;
  width: 90%;
}
</style>
