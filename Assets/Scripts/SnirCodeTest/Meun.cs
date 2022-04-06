using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Meun : MonoBehaviour
{
    
    public void LoadNext()
    {
        SceneManager.LoadScene(1);
    }

    public void GameOuit()
    {
        Application.Quit();
        Debug.Log("Quit");
    }
}
