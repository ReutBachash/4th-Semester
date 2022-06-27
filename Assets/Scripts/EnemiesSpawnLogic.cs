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

    [SerializeField] GameObject indicatorLeft;
    [SerializeField] GameObject indicatorMiddle;
    [SerializeField] GameObject indicatorRight;

    void Start()
    {
        _shootScript.onEnemyDeath += SpawnNextEnemy;

        //Add ZoneConfiguration

        _allEnemies[0].GetComponent<EnemiesMovement>().SetDestination(); //spawning first enemy
        _allEnemies[0].GetComponent<EnemyIdentity>().isAlive = true; //spawning first enemy
        changeByDirection(_allEnemies[0].GetComponent<EnemyIdentity>().direction);

    }
    private void changeByDirection(int direction)
    {
        switch (direction)
        {
            case 2:
                indicatorLeft.SetActive(true);
                indicatorMiddle.SetActive(false);
                indicatorRight.SetActive(false);
                break;
            case 1:
                indicatorLeft.SetActive(false);
                indicatorMiddle.SetActive(true);
                indicatorRight.SetActive(false);
                break;
            case 0:
                indicatorLeft.SetActive(false);
                indicatorMiddle.SetActive(false);
                indicatorRight.SetActive(true);
                break;
            default:
                break;
        }
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
                changeByDirection(_allEnemies[identity._enemyNumber + 1].GetComponent<EnemyIdentity>().direction);
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
        changeByDirection(_allEnemies[identity._enemyNumber + 1].GetComponent<EnemyIdentity>().direction);


    }
}
