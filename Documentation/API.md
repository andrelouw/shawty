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

## Album Info

``https://api.deezer.com/album/{album_id}``

### Example Payload
`GET https://api.deezer.com/album/373401057`

```json
{
  "id": 373401057,
  "title": "Thrill Of The Chase",
  "upc": "196589585011",
  "link": "https:\/\/www.deezer.com\/album\/373401057",
  "share": "https:\/\/www.deezer.com\/album\/373401057?utm_source=deezer&utm_content=album-373401057&utm_term=0_1685161376&utm_medium=web",
  "cover": "https:\/\/api.deezer.com\/album\/373401057\/image",
  "cover_small": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/56x56-000000-80-0-0.jpg",
  "cover_medium": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/250x250-000000-80-0-0.jpg",
  "cover_big": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/500x500-000000-80-0-0.jpg",
  "cover_xl": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/1000x1000-000000-80-0-0.jpg",
  "md5_image": "acb3c30b4d1225a0184445c005679f1c",
  "genre_id": 113,
  "genres": {
    "data": [
      {
        "id": 113,
        "name": "Dance",
        "picture": "https:\/\/api.deezer.com\/genre\/113\/image",
        "type": "genre"
      },
      {
        "id": 132,
        "name": "Pop",
        "picture": "https:\/\/api.deezer.com\/genre\/132\/image",
        "type": "genre"
      }
    ]
  },
  "label": "Kygo\/RCA Records",
  "nb_tracks": 14,
  "duration": 3186,
  "fans": 3353,
  "release_date": "2022-11-11",
  "record_type": "album",
  "available": true,
  "tracklist": "https:\/\/api.deezer.com\/album\/373401057\/tracks",
  "explicit_lyrics": false,
  "explicit_content_lyrics": 0,
  "explicit_content_cover": 2,
  "contributors": [
    {
      "id": 4768753,
      "name": "Kygo",
      "link": "https:\/\/www.deezer.com\/artist\/4768753",
      "share": "https:\/\/www.deezer.com\/artist\/4768753?utm_source=deezer&utm_content=artist-4768753&utm_term=0_1685161376&utm_medium=web",
      "picture": "https:\/\/api.deezer.com\/artist\/4768753\/image",
      "picture_small": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/56x56-000000-80-0-0.jpg",
      "picture_medium": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/250x250-000000-80-0-0.jpg",
      "picture_big": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/500x500-000000-80-0-0.jpg",
      "picture_xl": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/1000x1000-000000-80-0-0.jpg",
      "radio": true,
      "tracklist": "https:\/\/api.deezer.com\/artist\/4768753\/top?limit=50",
      "type": "artist",
      "role": "Main"
    }
  ],
  "artist": {
    "id": 4768753,
    "name": "Kygo",
    "picture": "https:\/\/api.deezer.com\/artist\/4768753\/image",
    "picture_small": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/56x56-000000-80-0-0.jpg",
    "picture_medium": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/250x250-000000-80-0-0.jpg",
    "picture_big": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/500x500-000000-80-0-0.jpg",
    "picture_xl": "https:\/\/e-cdns-images.dzcdn.net\/images\/artist\/df5ebed126f2e7402769782dae1e8c68\/1000x1000-000000-80-0-0.jpg",
    "tracklist": "https:\/\/api.deezer.com\/artist\/4768753\/top?limit=50",
    "type": "artist"
  },
  "type": "album",
  "tracks": {
    "data": [
      {
        "id": 2005342687,
        "readable": true,
        "title": "Gone Are The Days (feat. James Gillespie)",
        "title_short": "Gone Are The Days (feat. James Gillespie)",
        "title_version": "",
        "link": "https:\/\/www.deezer.com\/track\/2005342687",
        "duration": 196,
        "rank": 371680,
        "explicit_lyrics": false,
        "explicit_content_lyrics": 0,
        "explicit_content_cover": 2,
        "preview": "https:\/\/cdns-preview-c.dzcdn.net\/stream\/c-c1795d5d8ed3ad688d93ee80e2f06cb9-2.mp3",
        "md5_image": "acb3c30b4d1225a0184445c005679f1c",
        "artist": {
          "id": 4768753,
          "name": "Kygo",
          "tracklist": "https:\/\/api.deezer.com\/artist\/4768753\/top?limit=50",
          "type": "artist"
        },
        "album": {
          "id": 373401057,
          "title": "Thrill Of The Chase",
          "cover": "https:\/\/api.deezer.com\/album\/373401057\/image",
          "cover_small": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/56x56-000000-80-0-0.jpg",
          "cover_medium": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/250x250-000000-80-0-0.jpg",
          "cover_big": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/500x500-000000-80-0-0.jpg",
          "cover_xl": "https:\/\/e-cdns-images.dzcdn.net\/images\/cover\/acb3c30b4d1225a0184445c005679f1c\/1000x1000-000000-80-0-0.jpg",
          "md5_image": "acb3c30b4d1225a0184445c005679f1c",
          "tracklist": "https:\/\/api.deezer.com\/album\/373401057\/tracks",
          "type": "album"
        },
        "type": "track"
      }
    ]
  }
}
```

## Track List

`https://api.deezer.com/artist/{artistid}/albums`

### Model

| Property | Type |
| --- | --- |
| `id` | `int` |
| `title` | `string` |
| `duration` | `int` |

### Example Payload
`GET https://api.deezer.com/artist/373401057/albums`
```json
{
  "data": [
    {
      "id": 2005342687,
      "readable": true,
      "title": "Gone Are The Days (feat. James Gillespie)",
      "title_short": "Gone Are The Days (feat. James Gillespie)",
      "title_version": "",
      "isrc": "USRC12100639",
      "link": "https:\/\/www.deezer.com\/track\/2005342687",
      "duration": 196,
      "track_position": 1,
      "disk_number": 1,
      "rank": 371680,
      "explicit_lyrics": false,
      "explicit_content_lyrics": 0,
      "explicit_content_cover": 2,
      "preview": "https:\/\/cdns-preview-c.dzcdn.net\/stream\/c-c1795d5d8ed3ad688d93ee80e2f06cb9-2.mp3",
      "md5_image": "acb3c30b4d1225a0184445c005679f1c",
      "artist": {
        "id": 4768753,
        "name": "Kygo",
        "tracklist": "https:\/\/api.deezer.com\/artist\/4768753\/top?limit=50",
        "type": "artist"
      },
      "type": "track"
    },
  ],
  "total": 14
}
```
