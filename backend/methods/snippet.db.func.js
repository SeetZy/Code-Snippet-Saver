// Gets the data model
const SnippetModel = require('../models/snippet.model')

class SnippetService {
  // Method for creating a new snippet
  static async createSnippet(userId, fileName, fileType, snippet, description) {
    try {
      // Creates a new snippet
      const createSnippet = new SnippetModel({
        userId,
        fileName,
        fileType,
        snippet,
        description,
      })

      // Saves the snippet to the database
      return await createSnippet.save()
    } catch (error) {
      throw new Error(`Failed to save code snippet: ${error.message}`)
    }
  }

  // Method for getting all user snippets
  static async getSnippets(userId) {
    // Finds all of the snippets that belongs to a user
    const snippetData = await SnippetModel.find({ userId })

    return snippetData
  }

  // Method for updating a users snippet
  static async updateSnippet(id, snippet, description) {
    // Finds the designated snippet and updates it
    const updatedSnippetData = await SnippetModel.findByIdAndUpdate(
      { _id: id },
      { snippet, description },
      { new: true }
    )

    return updatedSnippetData
  }

  // Method for deleting a users snippet
  static async deleteSnippets(id) {
    // Finds the designated snippet and deletes it
    const deletedSnippetData = await SnippetModel.findOneAndDelete({ _id: id })

    return deletedSnippetData
  }
}

// Defines functions object to be exported
module.exports = snippetDbFunc = {
  // Exporting the createNewSnippet function for creating a new snippet
  createNewSnippet: async (req, res, next) => {
    try {
      const { userId, fileName, fileType, snippet, description } = req.body

      // Call SnippetService to create a new snippet
      let codeSnippet = await SnippetService.createSnippet(
        userId,
        fileName,
        fileType,
        snippet,
        description
      )

      // Send a JSON response with the created snippet
      res.json({ status: true, success: codeSnippet })
    } catch (error) {
      // Pass the error to the next middleware in the chain
      next(error)
    }
  },

  // Exporting the getUserSnippets function for getting snippets of a user
  getUserSnippets: async (req, res, next) => {
    try {
      const { userId } = req.query

      // Call SnippetService to get the snippets of the specified user
      let snippets = await SnippetService.getSnippets(userId)

      // Send a JSON response with the user's snippets
      res.json({ status: true, success: snippets })
    } catch (error) {
      // Pass the error to the next middleware in the chain
      next(error)
    }
  },

  // Exporting the updateUserSnippets function for updating a snippet
  updateUserSnippets: async (req, res, next) => {
    try {
      const { id } = req.params
      const { snippet, description } = req.body

      // Call SnippetService to update the specified snippet
      let updatedData = await SnippetService.updateSnippet(
        id,
        snippet,
        description
      )

      // Send a JSON response with the updated snippet
      res.json({ status: true, success: updatedData })
    } catch (error) {
      // Pass the error to the next middleware in the chain
      next(error)
    }
  },

  // Exporting the deleteUserSnippets function for deleting a snippet
  deleteUserSnippets: async (req, res, next) => {
    try {
      const { id } = req.body

      // Call SnippetService to delete the specified snippet
      let deletedData = await SnippetService.deleteSnippets(id)

      // Send a JSON response with the deleted snippet
      res.json({ status: true, success: deletedData })
    } catch (error) {
      // Pass the error to the next middleware in the chain
      next(error)
    }
  },
}
