export const theme = {
    container: {
        width: '30%',
    },
    suggestion: {
        listStyle: 'none',
        padding: "10px 20px",
        cursor: 'pointer',
        borderTop: "1px solid #eee"
    },
    suggestionFirst: {
        borderTop: "none"
    }, //below input styling not needed once SearchBar's input component is migrated to MaterialUI
    /*input: {
        width: '40%',
        borderRadius: "10px",
        borderBottomRightRadius: '10px',   //when returning from inputFocused, bottom corners do not...
        borderBottomLeftRadius: '10px',    //...round without these two lines.
        padding: '10px 20px',
        border: "1px solid #aaa"
    },*/
    inputFocused: {
        outline: 'none'
    },
    inputOpen: {
        borderBottomRightRadius: '0px',
        borderBottomLeftRadius: '0px'
    },
    suggestionsContainerOpen: {
        width: '100%',
        display: 'block',
        margin: '0px',
        padding: '0px',
        backgroundColor: 'white',
        borderBottomRightRadius: '10px',
        borderBottomLeftRadius: '10px',
        border: "1px solid #aaa"
    },
    suggestionsList: {
        margin: '0px',
        padding: '0px'
    },
    suggestionHighlighted: {
        backgroundColor: 'rgba(255,0,0,0.1)'
    }
}