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


## Album List

`https://api.deezer.com/artist/{artistid}/albums`

### Model


| Property | Type |
| --- | --- |
| `id` | `int` |
| `title` | `string` |
| `cover` | `url` |
| `genres` | `array<string>` |
| `duration` | `duration` |

### Example Payload

`GET https://api.deezer.com/artist/4768753/albums`
```json
{
  "data": [
    {
      "id": 373401057,
      "title": "Thrill Of The Chase",
      "link": "https:\/\/www.deezer.com\/album\/373401057",
      "cover": "https:\/\/api.deezer.com\/album\/373401057\/image",
      "cover_small": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/56x56-000000-80-0-0.jpg",
      "cover_medium": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/250x250-000000-80-0-0.jpg",
      "cover_big": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/500x500-000000-80-0-0.jpg",
      "cover_xl": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/1000x1000-000000-80-0-0.jpg",
      "md5_image": "acb3c30b4d1225a0184445c005679f1c",
      "genre_id": 113,
      "fans": 3353,
      "release_date": "2022-11-11",
      "record_type": "album",
      "tracklist": "https:\/\/api.deezer.com\/album\/373401057\/tracks",
      "explicit_lyrics": false,
      "type": "album"
    }
]
}
	"total": 64,
  "next": "https:\/\/api.deezer.com\/artist\/4768753\/albums?index=25"
}

```
