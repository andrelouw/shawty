# API
This Page contains details regarding the API for this app:
[Deezer](http://developers.deezer.com/api)

## Artist Search

`https://api.deezer.com/search/artist?q={query}`

### Model
| Property | Type |
| --- | --- |
| `id` | `int` |
| `name` | `string` |
| `picture` | `url` |

### Example Payload
`https://api.deezer.com/search/artist?q=kygo`

```json
{
  "data": [
    {
      "id": 4768753,
      "name": "Kygo",
      "link": "http:\/\/www.deezer.com\/artist\/4768753",
      "picture": "http:\/\/api.deezer.com\/artist\/4768753\/image",
      "picture_small": "http:\/\/e-cdn-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/56x56-000000-80-0-0.jpg",
      "picture_medium": "http:\/\/e-cdn-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/250x250-000000-80-0-0.jpg",
      "picture_big": "http:\/\/e-cdn-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/500x500-000000-80-0-0.jpg",
      "picture_xl": "http:\/\/e-cdn-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/1000x1000-000000-80-0-0.jpg",
      "nb_album": 64,
      "nb_fan": 2156459,
      "radio": true,
      "tracklist": "http:\/\/api.deezer.com\/artist\/4768753\/top?limit=50",
      "type": "artist"
    },
    ...
  ],
  "total": 63,
  "next": "http:\/\/api.deezer.com\/search\/artist?q=kygo%20&index=25"
}
```
