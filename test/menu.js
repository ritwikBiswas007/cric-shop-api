const subCategoryManualData = [
    {
        categoryId: 1,
        parent: true,
        //url:"/category/1/subcategory/2?idealFor=ADULT",
        section: 1,
        subCategoryName: 'Adult Bat'
    },
    {
        categoryId: 1,
        parent: false,
        url: "/category/1/subcategory/2?idealFor=ADULT",
        section: 1,
        subCategoryName: 'Adult2 Bat'
    },
    {
        categoryId: 1,
        parent: true,
        url: "/category/1/subcategory/2?idealFor=ADULT",
        section: 2,
        subCategoryName: 'Kids Bat'
    },
    {
        categoryId: 2,
        parent: true,
        url: "/category/1/subcategory/2?idealFor=ADULT",
        section: 1,
        subCategoryName: 'Leather Ball'
    }
]
var menu = [
    {
        subCategoryName: "CARICKET BATS",
        categoryId: 1,
        url: '/category/1',
        subMenu: [
            {
                categoryId: 1,
                parent: true,
                section: 1,
                subCategoryName: "ADULT BATS",
                url: '/category/1?idealFor=Adult'
            },
            {
                categoryId: 1,
                parent: false,
                section: 1,
                subCategoryName: "ENGLISH WILLOW",
                url: '/category/1?idealFor=Adult&materialType=ENGLISH WILLOW'
            },
            {
                categoryId: 1,
                parent: false,
                section: 1,
                subCategoryName: "KASHMIR WILLOW",
                url: '/category/1?idealFor=Adult&materialType=KASHMIR WILLOW'
            },
            {
                categoryId: 1,
                parent: false,
                section: 1,
                subCategoryName: "TAPE TENNIS BATS",
                url: '/category/1?idealFor=Adult&materialType=TAPE TENNIS BATS'
            },
            {
                categoryId: 1,
                parent: true,
                section: 2,
                subCategoryName: "KIDS BATS",
                url: '/category/1?idealFor=Kids'
            },
            {
                categoryId: 1,
                parent: false,
                section: 2,
                subCategoryName: "ENGLISH WILLOW",
                url: '/category/1?idealFor=Kids&materialType=ENGLISH WILLOW'
            },
            {
                categoryId: 1,
                parent: false,
                section: 2,
                subCategoryName: "KASHMIR WILLOW",
                url: '/category/1?idealFor=Kids&materialType=KASHMIR WILLOW'
            },
            {
                categoryId: 1,
                parent: false,
                section: 2,
                subCategoryName: "TAPE TENNIS BATS",
                url: '/category/1?idealFor=Kids&materialType=TAPE TENNIS BATS'
            },
            {
                categoryId: 1,
                parent: true,
                section: 3,
                subCategoryName: "BRANDS"
            }
        ]
    },
    {
        subCategoryName: "CRICKET BALLS",
        categoryId: 2,
        url: '/category/2',
        subMenu: [
            {
                categoryId: 2,
                parent: true,
                section: 1,
                subCategoryName: "ADULT BALLS",
                //url: '/category/2?idealFor=Adult',
            },
            {
                categoryId: 2,
                subCategoryId: 4,
                parent: false,
                section: 1,
                subCategoryName: "LEATHER BALLS",
                url: '/category/2/subCategory/4?idealFor=Adult'
            },
            {
                categoryId: 2,
                parent: false,
                section: 1,
                subCategoryName: "TENNIS BALLS",
                url: '/category/2/subCategory/4?idealFor=Adult'
            },
            {
                categoryId: 2,
                parent: false,
                subCategoryId: 3,
                section: 1,
                subCategoryName: "TRAINING BALLS",
                url: '/category/2/subCategory/3?idealFor=Adult'
            },
            {
                categoryId: 2,
                parent: true,
                section: 2,
                subCategoryName: "KIDS BALLS",
                //url: '/category/2?idealFor=Kids',
            },
            {
                categoryId: 2,
                parent: true,
                section: 2,
                subCategoryId: 4,
                url: '/category/2/subCategory/4?idealFor=Kids',
                subCategoryName: "LEATHER BALLS",
            },
            {
                categoryId: 2,
                parent: true,
                section: 2,
                subCategoryId: 4,
                url: '/category/2/subCategory/4?idealFor=Kids',
                subCategoryName: "TENNIS BALLS",
            },
            {
                categoryId: 2,
                parent: true,
                section: 2,
                subCategoryId: 3,
                url: '/category/2/subCategory/3?idealFor=Kids',
                subCategoryName: "TRAINING BALLS",
            }

        ]
    },
    {
        subCategoryName: "BATTING EQUIPMENT",
        categoryId: 5,
        subMenu: [
            {
                categoryId: 5,
                parent: false,
                section: 1,
                subCategoryId: 6,
                url: '/category/5/subCategory/6',
                subCategoryName: "BATTING GLOVES",
            },
            {
                categoryId: 5,
                parent: false,
                section: 1,
                subCategoryId: 7,
                url: '/category/5/subCategory/7',
                subCategoryName: "BATTING PADS",
            },
            {
                categoryId: 5,
                parent: false,
                section: 1,
                subCategoryId: 8,
                url: '/category/5/subCategory/8',
                subCategoryName: "BATTING INNER",
            },
            {
                categoryId: 5,
                parent: false,
                section: 1,
                subCategoryId: 9,
                url: '/category/5/subCategory/9',
                subCategoryName: "BATTING HELMETS",
            },
            {
                categoryId: 5,
                parent: false,
                section: 1,
                subCategoryId: 10,
                url: '/category/5/subCategory/10',
                subCategoryName: "BATTING PROTECTION",
            }
        ]
    },
    {
        subCategoryName: "FOOTWEAR",
        categoryId: 11,
        subMenu: [
            {
                categoryId: 11,
                parent: false,
                section: 1,
                subCategoryId: 12,
                url: '/category/11/subCategory/12',
                subCategoryName: "RUBBER SPIKES",
            },
            {
                categoryId: 11,
                parent: false,
                section: 1,
                subCategoryId: 12,
                url: '/category/11/subCategory/12',
                subCategoryName: "METAL SPIKES",
            },
            {
                categoryId: 11,
                parent: false,
                section: 1,
                subCategoryId: 12,
                url: '/category/11/subCategory/12',
                subCategoryName: "SOCKS",
            }
        ]
    },
    {
        subCategoryName: "KEEPERS",
        categoryId: 13,
        subMenu: [
            {
                categoryId: 13,
                parent: false,
                section: 1,
                subCategoryId: 14,
                url: '/category/13/subCategory/14',
                subCategoryName: "KEEPING GLOVES",
            },
            {
                categoryId: 13,
                parent: false,
                section: 1,
                subCategoryId: 15,
                url: '/category/13/subCategory/15',
                subCategoryName: "KEEPING PADS",
            },
            {
                categoryId: 13,
                parent: false,
                section: 1,
                subCategoryId: 16,
                url: '/category/13/subCategory/16',
                subCategoryName: "KEEPING INNER",
            }
        ]
    },
    {
        subCategoryName: "CLOTHING",
        categoryId: 17
    },
    {
        subCategoryName: "BAGS",
        categoryId: 20,
        subMenu: [
            {
                categoryId: 20,
                parent: false,
                section: 1,
                url: '/category/20?styleType=Duffle',
                subCategoryName: "DUFFLE",
            },
            {
                categoryId: 20,
                parent: false,
                section: 1,
                url: '/category/20?styleType=Wheelie',
                subCategoryName: "WHEELIE",
            },
            {
                categoryId: 20,
                parent: false,
                section: 1,
                url: '/category/20?styleType=Backpacks',
                subCategoryName: "BACKPACKS",
            }
        ]
    },
    {
        subCategoryName: "ACCESSORIES",
        categoryId: 25,
        subMenu: [
            {
                categoryId: 25,
                parent: false,
                section: 1,
                subCategoryId:27,
                url: '/category/25/subCategory/27',
                subCategoryName: "GRIPS",
            },
            {
                categoryId: 25,
                parent: false,
                section: 1,
                subCategoryId:28,
                url: '/category/25/subCategory/28',
                subCategoryName: "SCORECARD",
            },
            {
                categoryId: 25,
                parent: false,
                section: 1,
                subCategoryId:29,
                url: '/category/25/subCategory/29',
                subCategoryName: "UMPARING TOOLS",
            }
        ]
    }
]