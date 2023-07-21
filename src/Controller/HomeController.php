<?php

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(): Response
    {
        return $this->render('home/index.html.twig', [
            'title' => 'Base Symfony',
            'message' => 'Bienvenue sur la page d\'accueil'
        ]);
    }

    #[Route('/phpinfo', name: 'app_php_info')]
    public function phpinfo(): Response
    {
        phpinfo();
        return new Response('');
    }
}
