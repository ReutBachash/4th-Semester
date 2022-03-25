using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
public class EnemiesSpawnLogic : MonoBehaviour
{
    [SerializeField] Shoot _shootScript;
    [SerializeField] GameObject[] _allEnemies;

    private float delayForNextZoneSpawn = 2f;
    private int currentZoneNumber = 1;

    public event Action<int> onLastEnemykilledInZone;


    void Start()
    {
        _shootScript.onEnemyDeath += SpawnNextEnemy;

        //Add ZoneConfiguration

        _allEnemies[0].GetComponent<EnemiesMovement>().SetDestination(); //spawning first enemy
        _allEnemies[0].GetComponent<EnemyIdentity>().isAlive = true; //spawning first enemy


    }

    // Update is called once per frame
    private void SpawnNextEnemy(EnemyIdentity identity)
    {
        if (identity._enemyNumber<_allEnemies.Length)
        {        _allEnemies[identity._enemyNumber + 1].SetActive(true);

            if (!identity.isLastEnemyInZone)
            {
                _allEnemies[identity._enemyNumber + 1].GetComponent<EnemiesMovement>().SetDestination();
              
                _allEnemies[identity._enemyNumber + 1].GetComponent<Animator>().enabled = true;
                _allEnemies[identity._enemyNumber + 1].GetComponent<EnemyIdentity>().isAlive = true;
            }
            else
            {
                onLastEnemykilledInZone!.Invoke(currentZoneNumber);
                StartCoroutine(StartNextEnemyWithDelay(identity, delayForNextZoneSpawn));
                currentZoneNumber++;
            }
        }

       
    }
    IEnumerator  StartNextEnemyWithDelay(EnemyIdentity identity,float delay)
    {
        yield return new WaitForSeconds(delay);
        _allEnemies[identity._enemyNumber + 1].GetComponent<EnemiesMovement>().SetDestination();
        _allEnemies[identity._enemyNumber + 1].GetComponent<EnemyIdentity>().isAlive = true;
        _allEnemies[identity._enemyNumber + 1].GetComponent<Animator>().enabled = true;

    }
}
